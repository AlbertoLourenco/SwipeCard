//
//  CardItem.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import Foundation

struct Animal: Identifiable {
    
    var id = UUID()
    var order: Int
    var name: String
    var description: String
    var gallery: Array<String>
    
    var category: Category
}

extension Animal: Equatable {
    static public func ==(first: Animal, second: Animal) -> Bool {
        return first.id == second.id
    }
}
