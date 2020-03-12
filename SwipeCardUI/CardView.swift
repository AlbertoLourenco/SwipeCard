//
//  CardView.swift
//  SwipeCardUI
//
//  Created by Alberto Lourenço on 3/12/20.
//  Copyright © 2020 Alberto Lourenço. All rights reserved.
//

import SwiftUI

class Card: UIView {
    
    var imageName: String = "Avatar"
    var title: String = "Roberta Valença"
    
    private var lblTitle: UILabel!
    private var imgAvatar: UIImageView!
    
    private let layerMask = CAGradientLayer()
    private let emitterLayer = CAEmitterLayer()
    
    fileprivate lazy var emitterLike: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "Card-Particle-Like")?.cgImage
        cell.scale = 0.15
        cell.scaleRange = 0.4
        cell.emissionRange = .pi
        cell.lifetime = 3.0
        cell.birthRate = 10
        cell.velocity = -50
        cell.velocityRange = -20
        cell.yAcceleration = -50
        cell.xAcceleration = 15
        cell.spin = -0.5
        cell.spinRange = 1.0
        return cell
    }()
    
    fileprivate lazy var emitterSuperlike: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "Card-Particle-Superlike")?.cgImage
        cell.scale = 0.15
        cell.scaleRange = 0.4
        cell.emissionRange = .pi
        cell.lifetime = 3.0
        cell.birthRate = 10
        cell.velocity = -50
        cell.velocityRange = -20
        cell.yAcceleration = -50
        cell.xAcceleration = 15
        cell.spin = -0.5
        cell.spinRange = 1.0
        return cell
    }()
    
    fileprivate lazy var emitterDislike: CAEmitterCell = {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "Card-Particle-Dislike")?.cgImage
        cell.scale = 0.15
        cell.scaleRange = 0.4
        cell.emissionRange = .pi
        cell.lifetime = 3.0
        cell.birthRate = 10
        cell.velocity = -50
        cell.velocityRange = -20
        cell.yAcceleration = -50
        cell.xAcceleration = 15
        cell.spin = -0.5
        cell.spinRange = 1.0
        return cell
    }()
    
    override func layoutSubviews() {
        
        var frame = self.frame
        frame.origin.y += 50
        
        layerMask.frame = frame
    }
    
    func configUI() {
        
        self.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        
        //  Card
        
        self.backgroundColor = .clear
        
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        
        //  Image
        
        imgAvatar = UIImageView(image: UIImage(named: imageName))
        imgAvatar.contentMode = .scaleAspectFill
        imgAvatar.layer.cornerRadius = 15
        imgAvatar.clipsToBounds = true
        
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imgAvatar)
        
        //  Constraints
        
        NSLayoutConstraint.activate([
            imgAvatar.heightAnchor.constraint(equalTo: self.heightAnchor),
            imgAvatar.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        //  Title
        
        lblTitle = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: imgAvatar.bounds.width, height: 50)))
        lblTitle.textColor = .white
        lblTitle.text = title
        
        self.addSubview(lblTitle)
        
        //  Mask - gradient
        
        layerMask.opacity = 1
        layerMask.frame = imgAvatar.frame
        layerMask.backgroundColor = UIColor.clear.cgColor
        layerMask.colors = [UIColor.black.withAlphaComponent(0.8).cgColor,
                            UIColor.clear.cgColor,
                            UIColor.clear.cgColor]
        layerMask.startPoint = CGPoint(x: 0, y: 1)
        layerMask.endPoint = CGPoint(x: 0, y: 0)
        
        self.layer.insertSublayer(layerMask, below: lblTitle.layer)
        
        //  Emitter
        
        emitterLayer.emitterPosition = CGPoint(x: imgAvatar.bounds.width / 2.0,
                                               y: imgAvatar.bounds.height)
        emitterLayer.emitterSize = CGSize(width: imgAvatar.bounds.width, height: 0)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.timeOffset = 1
        
        self.layer.insertSublayer(emitterLayer, below: lblTitle.layer)
    }
    
    func updateEmitters(action: SwipeAction) {
        
        switch action {
            
            case .none:
                self.emitterLayer.emitterCells = []
            
            case .like:
                emitterLayer.emitterCells = [emitterLike]
            
            case .superlike:
                emitterLayer.emitterCells = [emitterSuperlike]
            
            case .dislike:
                emitterLayer.emitterCells = [emitterDislike]
        }
    }
}

enum SwipeAction {
    case none
    case like
    case superlike
    case dislike
}

struct CardView: UIViewRepresentable {

    let view = Card()
    
    var action: SwipeAction = .none
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> Card {
        
        view.configUI()
        
        return view
    }
    
    func updateUIView(_ uiView: Card, context: UIViewRepresentableContext<Self>) {
        
        uiView.updateEmitters(action: action)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
