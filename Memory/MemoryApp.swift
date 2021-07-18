//
//  MemoryApp.swift
//  Memory
//
//  Created by Samuel Barrett on 2021-07-08.
//

import SwiftUI

@main   // the main of the program.
struct MemoryApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)   // ContentView.swift is everything we see in the app.
        }
    }
}
