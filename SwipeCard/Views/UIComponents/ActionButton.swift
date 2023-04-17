//
//  ActionButton.swift
//  SwipeCard
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

struct ActionButton: View {
    
    var imageName: String = ""
    var overlayColor: Color = Color.blue
    var gradient: Gradient = Gradient(colors: [Color.blue, Color.purple])
    var onClick: () -> Void
    
    var body: some View {
    
        ZStack {
            
            LinearGradient(gradient: gradient,
                           startPoint: .bottom,
                           endPoint: .top)
            
            overlayColor.opacity(0.3)
            
            Image(imageName)
                .resizable()
                .renderingMode(Image.TemplateRenderingMode.template)
                .foregroundColor(Color.white)
                .scaledToFit()
                .frame(width: 35, height: 35)
        }
        .clipShape(Circle())
        .shadow(color: overlayColor.opacity(0.6), radius: 20, x: 0, y: 0)
        .frame(width: 70, height: 70, alignment: .center)
        .onTapGesture {
            self.onClick()
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(imageName: "Action-Like",
                     overlayColor: Color.blue,
                     gradient: Gradient(colors: [Color.blue, Color.purple])) {}
    }
}
