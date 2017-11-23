//
//  Utilities.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    class var hotPink: UIColor { return #colorLiteral(red: 0.8100712299, green: 0.1511939615, blue: 0.4035313427, alpha: 1) }
}

extension CGPoint{
    func distanceTo(_ point: CGPoint) -> CGFloat {
        return sqrt((point.x - x) * (point.x - x) + (point.y - y) * (point.y - y))
    }
}
