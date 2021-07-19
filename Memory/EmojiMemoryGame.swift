//
//  EmojiMemoryGame.swift
//  Memory
//
//  This is the ViewModel for our Emoji Memory game.
//  It is technically part of the UI (not the model), so it will import SwiftUI.
//
//  Created by Samuel Barrett on 2021-07-12.
//
//  TODO:
//  -   implement Theme color (currently the viewModel is not able to give the View the Theme color) use Color struct
//  -

import SwiftUI

// Note: ObservableObject behaviour allows us to let the world know when something has changed
//  in order to redraw the View. For this, we use @Published on our model so it signals whenever it is changed.
class EmojiMemoryGame: ObservableObject {
    // themes of this game
    private var currentTheme: Theme?
    private var themes: [Theme]
    init() {
        themes = [
            Theme(id: 1, name: "Nature", color: "green", numPairs: 4, ["🌸","🍁","🌷","🌵", "🌴", "🍄"]),
            Theme(id: 2, name: "Fruit", color: "red", numPairs: 5, ["🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🥝", "🥑", "🥥", "🍍"]),
            Theme(id: 3, name: "Animals", color: "yellow", numPairs: 5, ["🐝", "🦆", "🐢", "🦋", "🦀"]),
            Theme(id: 4, name: "Flags", color: "blue", numPairs: 6, ["🇨🇦", "🇺🇸", "🇸🇪", "🇬🇧", "🇲🇽", "🇯🇵"])
        ]
        currentTheme = themes.randomElement()
        currentTheme!.shuffleElements()
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme!)
    }
    
    // type function (tied to the whole type, exists only once, not instanced)
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        // handle the Optional returned by randomElement
        return MemoryGame<String>(numberOfPairsOfCards: min(theme.numPairs, theme.elements.count) ) { pairIndex in
            theme.elements[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
        
    // MARK: - Accessors:
    // allows read-only access to the Cards since model is private.
    // computed var since we want the freshest info every time.
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // read-only access to the score of the game (used by the View)
    var score: Int {
        return model.score
    }
    // return the name of the active theme
    var theme: String {
        if let safeCurrentTheme = currentTheme {
            return safeCurrentTheme.name
        }
        else {
            return ""
        }
    }
    var color: Color {
        let colorName = currentTheme!.color
        if colorName == "red" { return Color.red }
        else if colorName == "yellow" { return Color.yellow }
        else if colorName == "blue" { return Color.blue }
        else if colorName == "green" { return Color.green }
        else { return Color.purple }
    }
    
    // MARK: - Intent(s)
    // the user's intent to choose a card (wires the user action to the model)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    // allow the game to be reinitialized
    func newGame() {
        currentTheme = themes.randomElement()
        currentTheme!.shuffleElements()
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme!)
    }
}
