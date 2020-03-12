//
//  User.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import Foundation

struct User: Identifiable {
    
    var id = UUID()
    var order: Int
    var name: String
    var imageName: String
}
