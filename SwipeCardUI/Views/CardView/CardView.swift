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
    
    @State var action: SwipeAction = .none
    @State var dragState: CGSize = .zero
    
    var onRemove: (_ item: CardItem) -> Void
    
    var body: some View {
        
        ZStack {

            CardUI(item: item, action: action)
                .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - 280)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .rotationEffect(Angle(degrees: Double(self.dragState.width / 15.0)))
                .offset(self.dragState)
                .shadow(radius: 5)
                .padding(.horizontal)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            
                            self.isMoving = true
                            
                            self.action = .none
                            
                            if value.translation.height <= -80 {
                                self.action = .superlike
                            }
                            
                            if value.translation.width >= 80 {
                                self.action = .like
                            }else
                                if value.translation.width <= -80 {
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
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(item: CardItem(order: 0, text: "", imageName: "Avatar-1"),
                 isMoving: .constant(false)) { user in }
    }
}
