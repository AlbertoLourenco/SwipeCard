//
//  CardView.swift
//  SwipeCard
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

enum SwipeAction {
    case none
    case like
    case superlike
    case dislike
}

struct CardView: View {
    
    var item: Animal
    
    @Binding var isMoving: Bool
    @Binding var showingIndex: Int
    
    @State var pageIndex: Int = 0
    @State var isShowing: Bool = false
    @State var fullScreenGallery: Bool = false
    @State var dragState: CGSize = .zero
    @State var action: SwipeAction = .none
    
    var onRemove: (_ item: Animal) -> Void
    
    var body: some View {
        
        ZStack {

            ZStack {
                
                Color(UIColor(red:0.14, green:0.15, blue:0.16, alpha:1.0))
                    .edgesIgnoringSafeArea(.all)
                
                GalleryView(size: UIScreen.main.bounds.size,
                            items: item.gallery,
                            scrollEnabled: isShowing,
                            fullScreen: fullScreenGallery,
                            pageIndex: $pageIndex)
                    .frame(width: isShowing ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - 60,
                           height: isShowing ? UIScreen.main.bounds.height : UIScreen.main.bounds.height - 325)

                ParticleEmitterView(action: action)
                    .opacity(action != .none ? 1 : 0)
                    .animation(.easeInOut)
                
                if !isShowing {

                    VStack (alignment: .leading, spacing: 10) {
                        
                        Spacer()

                        HStack {

                            Image(item.category.imageName)
                                .resizable()
                                .renderingMode(Image.TemplateRenderingMode.template)
                                .foregroundColor(Color.white)
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .background(item.category.color)
                                .clipShape(Circle())
                            
                            Text(item.name)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                        
                        Divider()
                            .background(Color.white)
                        
                        Text(item.description)
                            .foregroundColor(Color.white)
                    }
                    .padding(20)
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .opacity(isShowing ? 0 : 1)
                }
            }
            .frame(width: isShowing ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - 60,
                   height: isShowing ? UIScreen.main.bounds.height : UIScreen.main.bounds.height - 325)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
            .animation(.easeInOut)
            
            if isShowing {

                VStack {

                    Spacer()
                    
                    PageControl(page: pageIndex, total: item.gallery.count)
                        .opacity(isShowing ? 1 : 0)
                        .offset(y: fullScreenGallery ? 200 : 0)
                        .animation(.spring())
                    
                    VStack (alignment: .leading, spacing: 20) {
                        
                        HStack {
                            
                            Image(item.category.imageName)
                                .resizable()
                                .renderingMode(Image.TemplateRenderingMode.template)
                                .foregroundColor(Color.white)
                                .padding(5)
                                .frame(width: 35, height: 35)
                                .background(item.category.color)
                                .clipShape(Circle())
                            
                            Text(item.name)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                        
                        Text(item.description)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                        
                        //-------------------------------------
                        //  Actions
                        //-------------------------------------
                        
                        VStack (alignment: .center) {

                            HStack (spacing: 25) {
                                
                                ActionButton(imageName: "Action-Dislike",
                                             overlayColor: Color.red,
                                             gradient: Gradient(colors: [Color.pink, Color.red])) {
                                                
                                                // TO DO - Dislike
                                                
                                                self.action = .dislike
                                                self.dismissWithAction()
                                }
                                
                                ActionButton(imageName: "Action-Superlike",
                                             overlayColor: Color.blue,
                                             gradient: Gradient(colors: [Color.blue, Color.purple])) {
                                                
                                                // TO DO - Superlike
                                                
                                                self.action = .superlike
                                                self.dismissWithAction()
                                }
                                
                                ActionButton(imageName: "Action-Like",
                                             overlayColor: Color.yellow,
                                             gradient: Gradient(colors: [Color.green, Color.yellow])) {
                                                
                                                // TO DO - Like
                                                
                                                self.action = .like
                                                self.dismissWithAction()
                                }
                            }
                            .scaleEffect(0.75)
                        }
                        .frame(width: UIScreen.main.bounds.width - 30)
                    }
                    .padding(20)
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color(UIColor(red:0.07, green:0.16, blue:0.21, alpha:1.0)))
                    .offset(y: isShowing ? 0 : 300)
                    .offset(y: fullScreenGallery ? 300 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .opacity(isShowing ? 1 : 0)
                    .animation(.easeInOut)
                }
            }
        }
        .rotationEffect(Angle(degrees: isShowing ? 0 : Double(self.dragState.width / 15.0)))
        .offset(self.dragState)
        .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            isShowing ?
                //-----------------------------------------------------
                //  Drag - dismiss (to close detail view)
                //-----------------------------------------------------
                DragGesture()
                    .onChanged{ value in
                        
                        self.isMoving = true
                        
                        var translation = value.translation
                        translation.width = 0
                        
                        self.dragState = translation
                        
                        if self.dragState.height < 0 {
                            self.dragState = .zero
                        }
                        
                        if self.dragState.height > 50 {
                            self.dismissDetail()
                        }
                }
                .onEnded{ value in
                    
                    if self.dragState.height < 50 {
                        self.dragState = .zero
                    }
                }
            :
                //-----------------------------------------------------
                //  Drag - actions (like, dislike and superlike)
                //-----------------------------------------------------
                DragGesture()
                    .onChanged{ value in
                        
                        self.dragState = value.translation
                        
                        self.isMoving = true
                        
                        if value.translation.width <= -50 {
                            self.action = .dislike
                            return
                        }
                        
                        if value.translation.width >= 50 {
                            self.action = .like
                            return
                        }
                        
                        if value.translation.height <= -120 {
                            self.action = .superlike
                            return
                        }
                        
                        self.action = .none
                }
                .onEnded{ value in
                    
                    self.isMoving = false
                    
                    if self.action != .none {
                        
                        self.onRemove(self.item) // remove item from array
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.action = .none
                            self.dragState = .zero
                        }
                    }else{
                        self.action = .none
                        self.dragState = .zero
                    }
            }
        )
        .onTapGesture {
            
            if self.isShowing == false {

                self.action = .none
                self.isShowing = true
                self.showingIndex = self.item.order
            }else{
                self.fullScreenGallery.toggle()
            }
        }
    }
    
    private func dismissDetail() {

        self.dragState = .zero
        self.showingIndex = -1
        self.fullScreenGallery = false
        self.isShowing = false
    }
    
    private func dismissWithAction() {

        self.dismissDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            switch self.action {
                
                case .none:
                    self.dragState = .zero
                    break
                    
                case .like:
                    self.dragState = CGSize(width: 50, height: 0)
                    break
                    
                case .dislike:
                    self.dragState = CGSize(width: -50, height: 0)
                    break
                    
                case .superlike:
                    self.dragState = CGSize(width: 0, height: -120)
                    break
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                self.onRemove(self.item) // remove item from array
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(item: MockedData.animals().first!,
                 isMoving: .constant(false),
                 showingIndex: .constant(0),
                 isShowing: false) { user in }
    }
}
