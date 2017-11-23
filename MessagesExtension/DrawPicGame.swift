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

enum GameState: String {
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

//MARK: - Encoding, Decoding
extension DrawPicGame{
    var queryItems: [URLQueryItem]{
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: "word", value: word))
        items.append(URLQueryItem(name: "guesses", value: guesses.joined(separator: "::-::")))
        items.append(URLQueryItem(name: "drawerId", value: drawerId.uuidString))
        items.append(URLQueryItem(name: "gameState", value: gameState.rawValue))
        items.append(URLQueryItem(name: "gameId", value: gameId.uuidString))
        
        return items
    }
    
    init?(queryItems: [URLQueryItem]) {
        var word: String?
        var guesses = [String]()
        var drawerId: UUID?
        var gameId: UUID?
        for item in queryItems {
            guard let value = item.value else { continue }
            switch item.name {
            case "word":
                word = value
            case "guesses":
                guesses = value.components(separatedBy: "::-::")
            case "drawerId":
                drawerId = UUID(uuidString: value)
            case "gameState":
                self.gameState = GameState(rawValue: value)!
            case "gameId":
                gameId = UUID(uuidString: value)
            default:
                continue
            }
        }
        guard let decodedWord = word, let decodedDrawerId = drawerId, let decodedGameId = gameId else { return nil }
        self.word = decodedWord
        self.guesses = guesses
        self.currentDrawing = DrawingStore.image(forUUID: decodedGameId)
        self.drawerId = decodedDrawerId
        self.gameId = decodedGameId
    }
    
    init?(message: MSMessage?) {
        guard let messageURL = message?.url, let urlComponents = URLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        self.init(queryItems: queryItems)
    }
}
