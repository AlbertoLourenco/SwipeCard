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
    
    var item: CardItem
    
    @Binding var isMoving: Bool
    @Binding var showingIndex: Int
    
    @State var isShowing: Bool = false
    @State var dragState: CGSize = .zero
    @State var action: SwipeAction = .none
    
    var onRemove: (_ item: CardItem) -> Void
    
    var body: some View {
        
        ZStack {

            CardUI(item: item, action: action)
                .frame(width: isShowing ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - 60,
                       height: isShowing ? UIScreen.main.bounds.height : UIScreen.main.bounds.height - 400)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .rotationEffect(Angle(degrees: isShowing ? 0 : Double(self.dragState.width / 15.0)))
                .offset(self.dragState)
                .shadow(radius: 5)
                .padding(.horizontal)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    
                    isShowing ?
                                          DragGesture()
                                              .onChanged{ value in
                                                  
                                                self.isMoving = true

                                                var translation = value.translation
                                                translation.width = 0
                                                
                                                self.dragState = translation
                                                
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
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(item: CardItem(order: 0,
                                text: "It is a long established fact that a reader will be distracted by the readable content.",
                                imageName: "Avatar-1"),
                 isMoving: .constant(false),
                 showingIndex: .constant(0)) { user in }
    }
}
