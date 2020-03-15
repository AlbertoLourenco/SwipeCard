//
//  CardUI.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct CardUI: UIViewRepresentable {
    
    var item: Animal!
    var action: SwipeAction = .none
    var showing: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> Card {
        
        let vwCard = Card().loadNib()
        vwCard.configUI(item: item)
        return vwCard
    }
    
    func updateUIView(_ view: Card, context: UIViewRepresentableContext<Self>) {
        
        view.updateShowing(showing)
        view.updateEmitters(action: action)
    }
}

struct CardUI_Previews: PreviewProvider {
    static var previews: some View {
        CardUI(item: MockedData.animals().first!, action: .like)
    }
}
