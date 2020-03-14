//
//  CardView.swift
//  SwipeCardUI
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
    
    @State var isShowing: Bool = false
    @State var dragState: CGSize = .zero
    @State var action: SwipeAction = .none
    
    var onRemove: (_ item: Animal) -> Void
    
    var body: some View {
        
        ZStack {

            CardUI(item: item, action: action)
                .frame(width: isShowing ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - 60,
                       height: isShowing ? UIScreen.main.bounds.height : UIScreen.main.bounds.height - 400)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)
                .animation(.easeInOut)
            
            VStack {

                Spacer()
                
                HStack {
                    Text(self.item.description)
                        .padding(20)
                }
                .frame(height: 200)
                .background(VisualEffectView(effect: UIBlurEffect(style: .regular)).background(Color(UIColor(red:0.23, green:0.20, blue:0.61, alpha:1.0)).opacity(0.1)))
                .offset(y: isShowing ? 0 : 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .opacity(isShowing ? 1 : 0)
                .animation(.easeInOut)
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
                                        
                                        if self.dragState.height > 100 {

                                            self.dragState = .zero
                                            self.showingIndex = -1
                                            self.isShowing = false
                                        }
                                      }
                                      .onEnded{ value in
                                        
                                        if self.dragState.height < 100 {
                                            self.dragState = .zero
                                        }
                                      }
            :
                //-----------------------------------------------------
                //  Drag - actions (like, dislike and superlike)
                //-----------------------------------------------------
                               DragGesture()
                                   .onChanged{ value in
                                       
                                       self.isMoving = true
                                       
                                       self.action = .none
                                       
                                       if value.translation.height <= -120 {
                                           self.action = .superlike
                                       }
                                       
                                       if value.translation.width >= 50 {
                                           self.action = .like
                                       }else
                                           if value.translation.width <= -50 {
                                               self.action = .dislike
                                           }

                                       self.dragState = value.translation
                                   }
                                   .onEnded{ value in
                                       
                                       self.isMoving = false
                                       
                                       if self.action != .none {
                                           self.onRemove(self.item)
                                           
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
            
            self.isShowing = true
            
            self.showingIndex = self.item.order
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(item: MockedData.animals().first!,
                 isMoving: .constant(false),
                 showingIndex: .constant(0),
                 isShowing: true) { user in }
    }
}
