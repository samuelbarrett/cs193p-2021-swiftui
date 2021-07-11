//
//  ContentView.swift
//  Memory
//
//  Created by Samuel Barrett on 2021-07-08.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🥝", "🥑"]
    @State var emojiCount = 6
    // all Views must implement body, type is "something that behaves like a View"
    // it's not stored in memory, it's calculated (by a function that returns the contents each time it's called).
    var body: some View {
        VStack {
            // the grid of Cards (VGrid requires # of columns, entered as array of GridItems.
            //  these GridItems are highly customizable if we want.
            ScrollView {
                // the Lazy means it only accesses body var of Views currently on the screen.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)    // define Card aspect
                    }
                }
            }
            .foregroundColor(.red)
            
            // the buttons below the cards
            Spacer()
            HStack {
                remove
                Spacer()    // eat up all available space
                add
            }
            .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
    // the add button
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
                
        })
    }
    // the remove button (see how we've further minimized the code compared to above?)
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false // must have a value at all times (cannot declare without giving it a value).
    // @State is a temporary solution to implement isFaceUp since we don't have game logic.
    // It turns the variable into a pointer to a Bool var in memory (because Views are immutable, so without this, we will error when attempting to change isFaceUp.
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                shape.fill()
            }
            
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
    }
}
