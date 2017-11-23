//
//  GuessViewController.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Foundation
import UIKit

protocol GuessViewControllerDelegate {
    func handleGuessSubmission(forGame game: DrawPicGame, guess: String)
}

class GuessViewController: UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    
    var game: DrawPicGame? {
        didSet { update(forGame: game) }
    }
    var delegate: GuessViewControllerDelegate?
    
    @IBAction func handleGuessSubmission(_ sender: UIButton) {
        guard var game = game else { return }
        guard let guess = guessTextField.text else { return }
        
        if game.valid(guess: guess) {
            game.gameState = .guess
            delegate?.handleGuessSubmission(forGame: game, guess: guess)
        } else {
            self.game?.guesses.append(guess)
            print("This has already been guessed! Try again!")
        }
    }
    
    private func update(forGame game: DrawPicGame?) {
        guard let game = game else { return }
        imageView?.image = game.currentDrawing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(forGame: game)
    }
}
