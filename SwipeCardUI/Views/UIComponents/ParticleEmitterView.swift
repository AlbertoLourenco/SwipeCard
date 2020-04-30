//
//  ParticleEmitterView.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/14/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import UIKit
import SwiftUI

struct ParticleEmitterView: UIViewRepresentable {
    
    var action: SwipeAction = .none
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> ParticleEmitter {
        
        let vwEmitter = ParticleEmitter()
        vwEmitter.configUI()
        return vwEmitter
    }
    
    func updateUIView(_ view: ParticleEmitter, context: UIViewRepresentableContext<Self>) {
        view.updateEmitters(action: action)
    }
}

class ParticleEmitter: UIView {
    
    private var vwActionMask: UIView!
    private let emitterLayer = CAEmitterLayer()
    
    func configUI() {
        
        self.frame = UIScreen.main.bounds
        
        self.backgroundColor = .clear
        
        self.vwActionMask = UIView(frame: UIScreen.main.bounds)
        self.vwActionMask.alpha = 0
        self.addSubview(self.vwActionMask)
        
        self.emitterLayer.emitterPosition = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height)
        self.emitterLayer.emitterSize = CGSize(width: self.bounds.width, height: 50)
        self.emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        self.emitterLayer.beginTime = CACurrentMediaTime()
        self.emitterLayer.timeOffset = 1
        
        self.layer.addSublayer(emitterLayer)
    }
    
    func updateEmitters(action: SwipeAction) {
        
        switch action {
            
            case .none:
                UIView.animate(withDuration: 0.3) {
                    self.vwActionMask.alpha = 0
                    self.emitterLayer.opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.emitterLayer.emitterCells = []
                }
                break
            
            case .like:
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {

                    self.emitterLayer.emitterCells = [self.getEmitterCell(for: action)]
                    
                    UIView.animate(withDuration: 0.3) {
                        self.vwActionMask.backgroundColor = UIColor.black
                        self.vwActionMask.alpha = 0.3
                        self.emitterLayer.opacity = 1
                    }
                }
                break
            
            case .superlike:
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {

                    self.emitterLayer.emitterCells = [self.getEmitterCell(for: action)]
                    
                    UIView.animate(withDuration: 0.3) {
                        self.vwActionMask.backgroundColor = UIColor.blue
                        self.vwActionMask.alpha = 0.1
                        self.emitterLayer.opacity = 1
                    }
                }
                break
            
            case .dislike:
                
                UIView.animate(withDuration: 0.3) {
                    self.vwActionMask.backgroundColor = UIColor.red
                    self.vwActionMask.alpha = 0.3
                    self.emitterLayer.opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.emitterLayer.emitterCells = []
                }
                break
        }
    }
    
    private func getEmitterCell(for action: SwipeAction) -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        
        switch action {
            
            case .like:
                cell.contents = UIImage(named: "Card-Particle-Like")?.cgImage
            
            case .superlike:
                cell.contents = UIImage(named: "Card-Particle-Superlike")?.cgImage
            
            case .dislike:
                cell.contents = UIImage(named: "Card-Particle-Dislike")?.cgImage
            
            default:
                break
        }
        
        cell.scale = 0.15
        cell.scaleRange = 0.4
        cell.emissionRange = .pi
        cell.lifetime = 5.0
        cell.birthRate = 25
        cell.velocity = -50
        cell.velocityRange = -20
        cell.yAcceleration = -50
        cell.xAcceleration = 15
        cell.spin = -0.5
        cell.spinRange = 1.0
        
        return cell
    }
}

struct ParticleEmitterView_Previews: PreviewProvider {
    static var previews: some View {
        ParticleEmitterView(action: .like)
    }
}
