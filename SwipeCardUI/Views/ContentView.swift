//
//  ContentView.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct Contants {

    static var page_01: Array<User> = [User(order: 0, name: "Gabriela Ramos", imageName: "Avatar-3"),
                                       User(order: 1, name: "Maria Eduarda", imageName: "Avatar-2"),
                                       User(order: 2, name: "Roberta Valença", imageName: "Avatar-1")]
    
    static var page_02: Array<User> = [User(order: 3, name: "AAAAAAAA", imageName: "Avatar-2"),
                                       User(order: 4, name: "SSSSSSS", imageName: "Avatar-3"),
                                       User(order: 5, name: "GGGGGGGG", imageName: "Avatar-1"),
                                       User(order: 6, name: "DDDDDDD", imageName: "Avatar-3"),
                                       User(order: 3, name: "FFFFFFF", imageName: "Avatar-2"),
                                       User(order: 5, name: "WWWWWWW", imageName: "Avatar-1")]
}

struct ContentView: View {
    
    @State var translation: CGSize = .zero
    
    @State var items: Array<User> = Contants.page_01
    @State var dismissCard: Bool = false
    @State var cardState: SwipeAction = .none

    var body: some View {
        
        VStack {

            GeometryReader { geometry in
                
                ForEach(self.items) { item in
                    
                    CardView(user: item, onRemove: { user in
                        
                        self.items.removeAll { $0.id == user.id }
                        
                        if self.items.count == 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.items = Contants.page_02
                            }
                        }
                    })
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
                    .rotationEffect(Angle(degrees: Double.random(in: -5...5)))
                }
            }
            .animation(.spring())
            
            Spacer()
            
            HStack (spacing: 50) {
                
                Button("Dislike") {
                    
                }
                
                Button("Superlike") {
                    
                }
                
                Button("Like") {
                    
                }
            }
            .opacity((translation == .zero) ? 1 : 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
