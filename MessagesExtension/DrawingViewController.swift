//
//  DrawingViewController.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

protocol DrawingViewControllerDelegate {
    func handleDrawingComplete(game: DrawPicGame?)
}

class DrawingViewController: UIViewController{
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var progressCircle: ProgressCircle!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var game: DrawPicGame? {
        didSet{
            update(forGame: game)
        }
    }
    
    var maxInkAllowed: CGFloat = 100
    var delegate: DrawingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.delegate = self
        update(forGame: game)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        maxInkAllowed = view.bounds.width
    }
    
    @IBAction func handleDoneButtonTapped(_ sender: UIButton) {
        if let drawing = canvas.image {
            game?.currentDrawing = drawing
        }
        game?.gameState = .challenge
        delegate?.handleDrawingComplete(game: game)
    }
    
    private func update(forGame game: DrawPicGame?){
        guard let game = game else {return}
        canvas?.image = game.currentDrawing
        instructionLabel?.text = game.word
    }
}

extension DrawingViewController: CanvasDelegate {
    func didUpdate(canvas: Canvas, inkUsed: CGFloat) {
        let proportion = inkUsed / maxInkAllowed
        progressCircle.progress = proportion
        
        if(proportion > 1) {
            canvas.enabled = false
        }
    }
}
