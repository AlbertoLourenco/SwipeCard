//
//  ContentView.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var socialAction: SwipeAction = .none
    
    @State var showingIndex: Int = -1
    @State var isShowing: Bool = false
    @State var isLoading: Bool = false
    @State var isMovingCard: Bool = false
    @State var items: Array<Animal> = MockedData.animals()
    
    var body: some View {
        
        ZStack {

            Color(UIColor(red:0.10, green:0.18, blue:0.27, alpha:1.0))
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            Text("Loading more...")
                .foregroundColor(Color(UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)))
                .opacity(isLoading ? 1 : 0)
                .scaleEffect(isLoading ? 1 : 0.3)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
            
            ParticleEmitterView(action: socialAction)
                .opacity(socialAction != .none ? 1 : 0)
                .animation(.easeInOut)
            
            //-------------------------------------
            //  Actions
            //-------------------------------------
            
            VStack {
                
                Spacer()
                
                HStack (spacing: 25) {
                    
                    ActionButton(imageName: "Action-Dislike",
                                 overlayColor: Color.red,
                                 gradient: Gradient(colors: [Color.pink, Color.red])) {
                                    
                                    // TO DO - Dislike
                                    
                                    self.socialAction = .dislike

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.items.removeLast()
                                        self.handlePagination()
                                    }
                    }
                    .disabled(isMovingCard)
                    .opacity(isMovingCard ? 0.3 : 1)
                    .animation(.easeInOut(duration: 0.3))
                    
                    ActionButton(imageName: "Action-Superlike",
                                 overlayColor: Color.blue,
                                 gradient: Gradient(colors: [Color.blue, Color.purple])) {
                                    
                                    // TO DO - Superlike
                                    
                                    self.socialAction = .superlike
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.items.removeLast()
                                        self.handlePagination()
                                    }
                    }
                    .disabled(isMovingCard)
                    .opacity(isMovingCard ? 0.3 : 1)
                    .animation(.easeInOut(duration: 0.3))
                    
                    ActionButton(imageName: "Action-Like",
                                 overlayColor: Color.yellow,
                                 gradient: Gradient(colors: [Color.green, Color.yellow])) {
                                    
                                    // TO DO - Like
                                    
                                    self.socialAction = .like
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.items.removeLast()
                                        self.handlePagination()
                                    }
                    }
                    .disabled(isMovingCard)
                    .opacity(isMovingCard ? 0.3 : 1)
                    .animation(.easeInOut(duration: 0.3))
                }
                .opacity(showingIndex != -1 ? 0 : 1)
                .animation(.easeInOut(duration: 0.3))
            }
            
            //-------------------------------------
            //  Cards
            //-------------------------------------

            GeometryReader { geometry in

                ForEach(self.items) { item in
                    
                    CardView(item: item, isMoving: self.$isMovingCard, showingIndex: self.$showingIndex) { object in

                        self.items.removeAll { $0.id == object.id }

                        self.handlePagination()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .rotationEffect(Angle(degrees: (self.showingIndex == item.order) ? 0 : Double.random(in: -5...5)))
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .animation(.spring())
            .offset(y: -75)
        }
    }
    
    func handlePagination() {

        if self.items.count == 0 {
            
            self.isLoading = true
            self.isMovingCard = true
            self.socialAction = .none
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                self.isLoading = false
                self.isMovingCard = false
                
                self.items = MockedData.animals() // pagination
            }
        }else{
            self.socialAction = .none
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
