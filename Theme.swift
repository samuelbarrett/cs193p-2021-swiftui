//
//  Theme.swift
//  Memory
//
//  Created by Samuel Barrett on 2021-07-14.
//
//  A basic Theme struct which allows for specification of the Theme of some game, object or app.

import Foundation

struct Theme: Identifiable {
    private(set) var name: String
    private(set) var elements: [String]
    private(set) var color: String
    var numPairs: Int
    var id: Int
    
    init(id: Int, name: String, color: String, numPairs: Int, _ elements: Array<String>) {
        self.id = id
        self.name = name
        self.elements = elements
        self.color = color
        self.numPairs = numPairs
    }
    
    // shuffle the elements of the Theme
    mutating func shuffleElements() {
        elements.shuffle()
    }
}
