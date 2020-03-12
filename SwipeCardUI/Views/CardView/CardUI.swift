//
//  CardUI.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct CardUI: UIViewRepresentable {
    
    var user: User!
    var action: SwipeAction = .none
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> Card {
        
        let vwCard = Card().loadNib()
        vwCard.configUI(frame: UIScreen.main.bounds, user: user)
        
        vwCard.updateEmitters(action: .like)
        
        return vwCard
    }
    
    func updateUIView(_ uiView: Card, context: UIViewRepresentableContext<Self>) {
        
        uiView.updateEmitters(action: action)
    }
}

struct CardUI_Previews: PreviewProvider {
    static var previews: some View {
        CardUI(user: User(order: 0, name: "Roberta Valença", imageName: "Avatar-1"), action: .like)
    }
}
