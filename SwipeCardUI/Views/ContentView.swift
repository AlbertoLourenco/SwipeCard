//
//  ContentView.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct Contants {

    static var items: Array<CardItem> = [CardItem(order: 3, text: "If you're going to use 'Lorem Ipsum', you need to be sure there isn't anything embarrassing.", imageName: "Avatar-4"),
                                         CardItem(order: 2, text: "There are many variations of passages of Lorem Ipsum available.", imageName: "Avatar-3"),
                                         CardItem(order: 1, text: "Many desktop publishing packages and web page editors now use Lorem Ipsum.", imageName: "Avatar-2"),
                                         CardItem(order: 0, text: "It is a long established fact that a reader will be distracted by the readable content.", imageName: "Avatar-1")]
}

struct ContentView: View {
    
    @State var isLoading: Bool = false
    @State var isMovingCard: Bool = false
    @State var items: Array<CardItem> = Contants.items
    
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
            
            VStack {
                
                //-------------------------------------
                //  Cards
                //-------------------------------------
                
                GeometryReader { geometry in

                    ForEach(self.items) { item in

                        CardView(item: item, isMoving: self.$isMovingCard) { object in

                            self.items.removeAll { $0.id == object.id }

                            self.handlePagination()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
                        .rotationEffect(Angle(degrees: Double.random(in: -5...5)))
                    }
                }
                .animation(.spring())
                
                Spacer()
                
                //-------------------------------------
                //  Actions
                //-------------------------------------
                
                HStack (spacing: 25) {
                    
                    OptionButton(imageName: "Option-Dislike",
                                 overlayColor: Color.red,
                                 gradient: Gradient(colors: [Color.pink, Color.red])) {
                                    // TO DO - Dislike
                                    self.items.removeLast()
                                    self.handlePagination()
                    }
                    .disabled(isMovingCard)
                    
                    OptionButton(imageName: "Option-Superlike",
                                 overlayColor: Color.blue,
                                 gradient: Gradient(colors: [Color.blue, Color.purple])) {
                                    // TO DO - Superlike
                                    self.items.removeLast()
                                    self.handlePagination()
                    }
                    .disabled(isMovingCard)
                    
                    OptionButton(imageName: "Option-Like",
                                 overlayColor: Color.yellow,
                                 gradient: Gradient(colors: [Color.green, Color.yellow])) {
                                    // TO DO - Like
                                    self.items.removeLast()
                                    self.handlePagination()
                    }
                    .disabled(isMovingCard)
                }
                .opacity(isMovingCard ? 0.3 : 1)
                .animation(.easeInOut(duration: 0.3))
            }
        }
    }
    
    func handlePagination() {

        if self.items.count == 0 {
            
            self.isLoading = true
            self.isMovingCard = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                self.isLoading = false
                self.isMovingCard = false
                
                self.items = Contants.items // pagination
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
