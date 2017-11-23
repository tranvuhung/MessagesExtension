//
//  DrawPicGame.swift
//  DrawPic
//
//  Created by Trần Vũ Hưng on 11/22/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import UIKit
import Messages

let wordList = [ "nose", "dog", "camel", "fork", "pizza", "ray", "swift", "closure", "android", "gigabyte", "debugger", "tennis", "chocolate", "emoji", "toilet"]

struct DrawPicGame{
    let word: String
    var currentDrawing: UIImage?
    var guesses: [String]
    let drawerId: UUID
    let gameId: UUID
    var gameState = GameState.challenge
    
    init(word: String, drawerId: UUID){
        self.word = word
        self.drawerId = drawerId
        self.currentDrawing = .none
        self.guesses = [String]()
        self.gameId = UUID()
    }
}

enum GameState{
    case challenge
    case guess
}

extension DrawPicGame{
    static func newGame(drawerId: UUID) -> DrawPicGame{
        let word = wordList[Int(arc4random_uniform(UInt32(wordList.count)))]
        return DrawPicGame(word: word, drawerId: drawerId)
    }
    
    func check(guess: String) -> Bool{
        return guess == word
    }
    
    func valid(guess: String) -> Bool{
        return !guess.contains(guess)
    }
    
    var isComplete: Bool{
        return guesses.contains(word)
    }
    
    func owner(conversation: MSConversation) -> Bool{
        return conversation.localParticipantIdentifier == drawerId
    }
}
