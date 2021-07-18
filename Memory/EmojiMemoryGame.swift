//
//  EmojiMemoryGame.swift
//  Memory
//
//  This is the ViewModel for our Emoji Memory game.
//  It is technically part of the UI (not the model), so it will import SwiftUI.
//
//  Created by Samuel Barrett on 2021-07-12.
//

import SwiftUI

// Note: ObservableObject behaviour allows us to let the world know when something has changed
//  in order to redraw the View. For this, we use @Published on our model so it signals whenever it is changed.
class EmojiMemoryGame: ObservableObject {
    // themes of this game
    static let themes = [
        Theme(id: 1, name: "Nature", color: "green", numPairs: 4, ["🌸","🍁","🌷","🌵", "🌴", "🍄"]),
        Theme(id: 2, name: "Fruit", color: "red", numPairs: 5, ["🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🥝", "🥑", "🥥", "🍍"]),
        Theme(id: 3, name: "Animals", color: "yellow", numPairs: 5, ["🐝", "🦆", "🐢", "🦋", "🦀"]),
        Theme(id: 4, name: "Flags", color: "blue", numPairs: 6, ["🇨🇦", "🇺🇸", "🇸🇪", "🇬🇧", "🇲🇽", "🇯🇵"])
    ]
    // type function (tied to the whole type, exists only once, not instanced)
    static func createMemoryGame() -> MemoryGame<String> {
        // TODO: implement randomElement and handle its Optional return
        var currentTheme = themes.randomElement()
        // handle the Optional returned by randomElement
        currentTheme!.shuffleElements()
        return MemoryGame<String>(numberOfPairsOfCards: min(currentTheme!.numPairs, currentTheme!.elements.count) ) { pairIndex in
            currentTheme!.elements[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
        
    // allows read-only access to the Cards since model is private.
    // computed var since we want the freshest info every time.
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    // the user's intent to choose a card (wires the user action to the model)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
