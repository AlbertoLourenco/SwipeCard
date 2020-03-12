//
//  ContentView.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardState: SwipeAction = .none
    @State var dragState: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            
            Color.gray.opacity(0.2)
            
            ZStack {
                
                ZStack {
                    Image("Avatar")
                        .frame(width: UIScreen.main.bounds.width - 60, height: 500)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .rotationEffect(Angle(degrees: -5))

                ZStack {
                    Image("Avatar")
                        .frame(width: UIScreen.main.bounds.width - 60, height: 500)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .frame(width: 280, height: 400)
                .rotationEffect(Angle(degrees: 5))
                
                ZStack {
                    CardView(action: cardState)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 500)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .rotationEffect(Angle.init(degrees: Double(dragState.width / 15.0)))
                .offset(x: dragState.width, y: dragState.height)
            }
            .shadow(radius: 5)
            .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        
                        self.cardState = .none
                        
                        if value.translation.width >= 80 {
                            self.cardState = .like
                        }else
                            if value.translation.width <= -80 {
                                self.cardState = .dislike
                            }

                        if value.translation.height <= -80 {
                            self.cardState = .superlike
                        }
                        
                        self.dragState = value.translation
                    }
                    .onEnded{ value in
                        self.dragState = .zero
                        
                        self.cardState = .none
                    }
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
