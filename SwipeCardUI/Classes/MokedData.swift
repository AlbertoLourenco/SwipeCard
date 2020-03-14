//
//  MokedData.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/14/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct MockedData {
    
    static func animals() -> Array<Animal> {
        
        let dog = Animal(order: 0,
                         name: "Dog",
                         description: "If you're going to use 'Lorem Ipsum', you need to be sure there isn't anything embarrassing.",
                         imageName: "Dog",
                         category: Category(color: Color.red, imageName: "Category-Dog"))
        
        let cat = Animal(order: 1,
                         name: "Cat",
                         description: "There are many variations of passages of Lorem Ipsum available.",
                         imageName: "Cat",
                         category: Category(color: Color.red, imageName: "Category-Cat"))
        
        let bird = Animal(order: 2,
                          name: "Bird",
                          description: "Many desktop publishing packages and web page editors now use Lorem Ipsum.",
                          imageName: "Bird",
                          category: Category(color: Color.red, imageName: "Category-Bird"))
        
        let octopus = Animal(order: 3,
                             name: "Octopus",
                             description: "There are many variations of passages of Lorem Ipsum available.",
                             imageName: "Octopus",
                             category: Category(color: Color.red, imageName: "Category-Octopus"))
        
        let owl = Animal(order: 4,
                         name: "Owl",
                         description: "It is a long established fact that a reader will be distracted by the readable content.",
                         imageName: "Owl",
                         category: Category(color: Color.red, imageName: "Category-Owl"))
        
        let frog = Animal(order: 5,
                          name: "Frog",
                          description: "If you're going to use 'Lorem Ipsum', you need to be sure there isn't anything embarrassing.",
                          imageName: "Frog",
                          category: Category(color: Color.red, imageName: "Category-Frog"))
        
        let snake = Animal(order: 6,
                           name: "Snake",
                           description: "There are many variations of passages of Lorem Ipsum available.",
                           imageName: "Snake",
                           category: Category(color: Color.red, imageName: "Category-Snake"))
        
        return [dog, cat, bird, octopus, owl, frog, snake].reversed()
    }
}
