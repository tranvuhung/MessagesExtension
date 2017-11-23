//
//  DrawingStore.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

enum DrawingStore {
    
    static func store(image: UIImage, forUUID: UUID) {
        guard let data = UIImagePNGRepresentation(image) else {
            return
        }
        UserDefaults.standard.set(data, forKey: forUUID.uuidString)
    }
    
    static func image(forUUID: UUID) -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: forUUID.uuidString)  else {
            return nil
        }
        return UIImage(data: data)
    }
}
