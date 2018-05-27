//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 0
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 1
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    var currentStory = StoryTree.tree.rootStory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO Step 3: Set the text for the storyTextView, topButton, bottomButton, and to T1_Story, T1_Ans1, and T1_Ans2
        updateStory()
    }

    func updateStory(){
        storyTextView.text = currentStory.text
        
        guard let choices = currentStory.choices, choices.count == 2 else {
            storyFinished()
            return
        }
        
        topButton.setTitle(choices[0].text, for: .normal)
        bottomButton.setTitle(choices[1].text, for: .normal)
        
    }
    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == -1 {
            restart()
        } else {
            let indexChosen = sender.tag
            guard let choices = currentStory.choices else {
                print("Error while getting stories...")
                restart()
                return
            }
            
            currentStory = choices[indexChosen].linkedTo
            updateStory()
        }
    }
    
    func restart() {
        currentStory = StoryTree.tree.rootStory
        topButton.tag = 0
        topButton.alpha = 1
        bottomButton.alpha = 1
        topButton.backgroundColor = UIColor.red
        
        updateStory()
    }
    
    func storyFinished(){
        bottomButton.alpha = 0
        
        topButton.alpha = 1
        topButton.backgroundColor = UIColor.lightGray
        topButton.tag = -1
        topButton.setTitle("Jogar Novamente?", for: .normal)
    }
}

