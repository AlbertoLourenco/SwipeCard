//
//  Card.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import UIKit

class Card: UIView {
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    @IBOutlet private weak var vwActionMask: UIView!
    @IBOutlet private weak var imgAvatar: UIImageView!
    
    private let emitterLayer = CAEmitterLayer()
    
    func loadNib() -> Card {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Card", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Card
    }
    
    func configUI(item: Animal) {
        
        //  Card
        
        self.backgroundColor = .clear
        
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        
        //  Image
        
        self.imgAvatar.image = UIImage(named: item.imageName)
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.layer.cornerRadius = 15
        self.imgAvatar.clipsToBounds = true
        
        //  Title
        
        self.lblTitle.text = item.name
        
        //  Description
        
        self.lblDescription.text = item.description
        
        //  Emitter
        
        self.emitterLayer.emitterPosition = CGPoint(x: imgAvatar.bounds.width / 2.0, y: imgAvatar.bounds.height)
        self.emitterLayer.emitterSize = CGSize(width: imgAvatar.bounds.width, height: 50)
        self.emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        self.emitterLayer.beginTime = CACurrentMediaTime()
        self.emitterLayer.timeOffset = 1
        
        self.layer.insertSublayer(emitterLayer, below: lblTitle.layer)
    }
    
    func updateEmitters(action: SwipeAction) {
        
        switch action {
            
            case .none:
                UIView.animate(withDuration: 0.3) {
                    self.vwActionMask.alpha = 0
                }
                self.emitterLayer.emitterCells = []
                break
            
            case .like:
                
                UIView.animate(withDuration: 0.3) {
                    self.vwActionMask.backgroundColor = UIColor.black
                    self.vwActionMask.alpha = 0.3
                }
            
                emitterLayer.emitterCells = [self.getEmitterCell(for: action)]
                break
            
            case .superlike:
                
                UIView.animate(withDuration: 0.3) {
                    self.vwActionMask.backgroundColor = UIColor.blue
                    self.vwActionMask.alpha = 0.1
                }
                
                emitterLayer.emitterCells = [self.getEmitterCell(for: action)]
                break
            
            case .dislike:
                
                UIView.animate(withDuration: 0.3) {
                    self.vwActionMask.backgroundColor = UIColor.red
                    self.vwActionMask.alpha = 0.3
                }
                
                self.emitterLayer.emitterCells = []
                // emitterLayer.emitterCells = [self.getEmitterCell(for: action)]
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
