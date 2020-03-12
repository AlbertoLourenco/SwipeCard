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
    
    var user: User!
    
    @State var action: SwipeAction = .none
    
    @State var dragState: CGSize = .zero
    
    private var onRemove: (_ user: User) -> Void
    private var thresholdPercentage: CGFloat = 0.5
    
    init(user: User, onRemove: @escaping (_ user: User) -> Void) {
        
        self.user = user
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        
        ZStack {

            CardUI(user: user, action: action)
                .frame(width: UIScreen.main.bounds.width - 60, height: 500)
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
                            
                            if self.action != .none {
                                self.onRemove(self.user)
                                
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
        CardView(user: User(order: 0, name: "Roberta Valença", imageName: "Avatar-1")) { user in }
    }
}
