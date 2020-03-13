//
//  CardItem.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import Foundation

struct CardItem: Identifiable {
    
    var id = UUID()
    var order: Int
    var text: String
    var imageName: String
}
