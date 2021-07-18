//
//  ContentView.swift
//  Memory
//
//  This is the View to our memory game.
//
//  Created by Samuel Barrett on 2021-07-08.
//

import SwiftUI

struct ContentView: View {
    // ObservedObject means we will observe it for any changes. Works in tandem with @Published in the ObservableObject ViewModel to receive the sent changes.
    @ObservedObject var viewModel: EmojiMemoryGame
    // all Views must implement body, type is "something that behaves like a View"
    // it's not stored in memory, it's calculated (by a function that returns the contents each time it's called).
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            // the grid of Cards (VGrid requires # of columns, entered as array of GridItems.
            //  these GridItems are highly customizable if we want.
            ScrollView {
                // the Lazy means it only accesses body var of Views currently on the screen.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)    // define Card aspect
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
    }
}
