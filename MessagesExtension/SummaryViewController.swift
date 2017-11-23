//
//  SummaryViewController.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

protocol SummaryViewControllerDelegate {
    func handleSummaryTap(forGame game: DrawPicGame?)
}

class SummaryViewController: UIViewController {
    var game: DrawPicGame? {
        didSet { update(forGame: game) }
    }
    var delegate: SummaryViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func handleActionButtonTapped(_ sender: UIButton) {
        delegate?.handleSummaryTap(forGame: game)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(forGame: game)
    }
    
    private func update(forGame game: DrawPicGame?) {
        imageView?.image = game?.currentDrawing
        if let drawing = game?.currentDrawing {
            imageView?.image = drawing
            actionButton?.setTitle("Submit Guess", for: [])
        } else {
            actionButton?.setTitle("New Game", for: [])
        }
    }
}
