//
//  Story.swift
//  Destini
//
//  Created by Rodolfo Queiroz on 2018-05-25.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Story {
    let text: String
    // If a story has no choices, it means it is a leaf in the tree story architecture
    var choices: [StoryChoice]? {
        didSet {
            if choices!.count != 2 { choices = nil }
        }
    }
    
    init(text: String) {
        self.text = text
    }
}
