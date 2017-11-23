//
//  ProgressCircle.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ProgressCircle: UIView {
    @IBInspectable
    var progress: CGFloat = 0 {
        didSet{
            updateProgress()
        }
    }
    
    let outerCricleLayer = CAShapeLayer()
    let innerCricleLayer = CAShapeLayer()
}

extension ProgressCircle{
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLayers()
    }
    
    override func tintColorDidChange() {
        styleLayers()
    }
}

extension ProgressCircle{
    var innerPath: CGPath{
        let path = UIBezierPath()
        
        let endAngle = 2 * .pi * progress - .pi / 2
        
        path.addArc(withCenter: innerCricleLayer.position, radius: innerCricleLayer.bounds.size.width / 2, startAngle: -.pi / 2, endAngle: endAngle, clockwise: true)
        path.addLine(to: CGPoint(x: innerCricleLayer.bounds.midX, y: innerCricleLayer.bounds.midX))
        path.addLine(to: CGPoint(x: innerCricleLayer.bounds.midX, y: 0))
        
        return path.cgPath
    }
    
    func layoutLayers() {
        let squareSize = min(bounds.width, bounds.height)
        let square = bounds.insetBy(dx: (bounds.width - squareSize) / 2, dy: (bounds.height - squareSize) / 2 )
        for lay in [outerCricleLayer, innerCricleLayer]{
            lay.bounds = square
            lay.position = CGPoint(x: bounds.midX, y: bounds.midY)
            layer.addSublayer(lay)
        }
        
        outerCricleLayer.path = UIBezierPath(ovalIn: outerCricleLayer.bounds).cgPath
        innerCricleLayer.path = innerPath
        
        styleLayers()
    }
    
    func updateProgress(){
        innerCricleLayer.path = innerPath
    }
    
    func styleLayers(){
        outerCricleLayer.lineWidth = 1
        outerCricleLayer.fillColor = UIColor.clear.cgColor
        
        innerCricleLayer.lineWidth = 0
        
        outerCricleLayer.strokeColor = tintColor.cgColor
        innerCricleLayer.fillColor = tintColor.withAlphaComponent(0.8).cgColor
    }
}
