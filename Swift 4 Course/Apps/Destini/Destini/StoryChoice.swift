//
//  StoryChoice.swift
//  Destini
//
//  Created by Rodolfo Queiroz on 2018-05-25.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class StoryChoice {
    let linkedTo: Story
    let text: String
    
    init(text: String, linksTo: Story) {
        self.linkedTo = linksTo
        self.text = text
    }
}
