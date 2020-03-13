//
//  CardUI.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct CardUI: UIViewRepresentable {
    
    var item: CardItem!
    var action: SwipeAction = .none
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> Card {
        
        let vwCard = Card().loadNib()
        vwCard.configUI(frame: UIScreen.main.bounds, item: item)

        return vwCard
    }
    
    func updateUIView(_ uiView: Card, context: UIViewRepresentableContext<Self>) {
        
        uiView.updateEmitters(action: action)
    }
}

struct CardUI_Previews: PreviewProvider {
    static var previews: some View {
        CardUI(item: CardItem(order: 0, text: "", imageName: "Avatar-1"), action: .like)
    }
}
