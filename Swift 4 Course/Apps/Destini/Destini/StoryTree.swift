//
//  StoryBank.swift
//  Destini
//
//  Created by Rodolfo Queiroz on 2018-05-25.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class StoryTree {
    static let tree: StoryTree = StoryTree()
    let rootStory: Story
    
    init(){
        let storyText1 = "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\"."
        let answer1a = "I\'ll hop in. Thanks for the help!"
        let answer1b = "Better ask him if he\'s a murderer first."
        
        let storyText2 = "He nods slowly, unphased by the question."
        let answer2a = "At least he\'s honest. I\'ll climb in."
        let answer2b = "Wait, I know how to change a tire."
        
        let storyText3 = "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box."
        let answer3a = "I love Elton John! Hand him the cassette tape."
        let answer3b = "It\'s him or me! You take the knife and stab him."
        
        let storyText4 = "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?"
        let storyText5 = "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in."
        let storyText6 = "You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\""
        
        let story1 = Story(text: storyText1)
        let story2 = Story(text: storyText2)
        let story3 = Story(text: storyText3)
        let story4 = Story(text: storyText4)
        let story5 = Story(text: storyText5)
        let story6 = Story(text: storyText6)
        
        let choice1a = StoryChoice(text: answer1a, linksTo: story3)
        let choice1b = StoryChoice(text: answer1b, linksTo: story2)
        story1.choices = [choice1a, choice1b]
        
        let choice2a = StoryChoice(text: answer2a, linksTo: story3)
        let choice2b = StoryChoice(text: answer2b, linksTo: story4)
        story2.choices = [choice2a, choice2b]
        
        let choice3a = StoryChoice(text: answer3a, linksTo: story5)
        let choice3b = StoryChoice(text: answer3b, linksTo: story6)
        story3.choices = [choice3a, choice3b]
        
        self.rootStory = story1
    }
}
