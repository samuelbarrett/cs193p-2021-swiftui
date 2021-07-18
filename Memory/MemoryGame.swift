//
//  MemoryGame.swift
//  Memory
//
//  This is the Model of our memory game.
//
//  Created by Samuel Barrett on 2021-07-12.
//

import Foundation   // no SwiftUI here, just the Foundation package

// CardContent is a don't care - we will define it when we call the MemoryGame

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>     // look but no touchy (so the ViewModel can't mess with it)
    
    private var indexOfOnlyFaceUpCard: Int?
    
    // initialize the game.
    // createCardContent is a function passed into init to help us create the cards since the Model doesn't know what type they should be.
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to the cards array.
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2 ))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    // find the requested Card from the Array and toggle its isFaceUp value.
    // mutating keyword lets program know the function can mutate/change the struct
    mutating func choose(_ card: Card) {
        // if the chosenIndex is within bounds, not face up, not matched, then proceed
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // if there is a card already face up, note its index
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // the cards are a match.
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfOnlyFaceUpCard = nil // reset
            } else {
                // make all cards face down (since there may be two cards face up already)
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle() // flip the chosen card
        }
        print(cards)
    }
    
    // we put this in here. Technically, it's called a MemoryGame.Card
    // this is more specific and clear than just having an outside struct.
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
