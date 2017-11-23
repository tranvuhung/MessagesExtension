//
//  Canvas.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

protocol CanvasDelegate{
    func didUpdate(canvas: Canvas, inkUsed: CGFloat)
}

class Canvas: UIView{
    var image: UIImage?{
        didSet{
            layer.contents = image?.cgImage
        }
    }
    
    var delegate: CanvasDelegate?
    var inkUsed: CGFloat = 0
    var enabled = true
    
    @IBInspectable
    public var strockeWidth: CGFloat = 4.0
    
    @IBInspectable
    public var strockeColor = UIColor.hotPink
}

extension Canvas{
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard enabled else {return}
        if let touch = touches.first{
            if traitCollection.forceTouchCapability == .available{
                let force = touch.force > 0 ? touch.force : 1
                addLine(fromPoint: touch.previousLocation(in: self), toPoint: touch.location(in: self), withForce: force)
            } else {
                addLine(fromPoint: touch.previousLocation(in: self), toPoint: touch.location(in: self))
            }
        }
    }
}

extension Canvas{
    func addLine(fromPoint: CGPoint, toPoint: CGPoint, withForce force: CGFloat = 1){
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        image?.draw(in: bounds)
        
        if let context = UIGraphicsGetCurrentContext(){
            context.move(to: fromPoint)
            context.addLine(to: toPoint)
            context.setLineCap(.round)
            context.setLineWidth(force * strockeWidth)
            
            strockeColor.setStroke()
            context.strokePath()
        }
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        inkUsed += fromPoint.distanceTo(toPoint)
        delegate?.didUpdate(canvas: self, inkUsed: inkUsed)
    }
}
