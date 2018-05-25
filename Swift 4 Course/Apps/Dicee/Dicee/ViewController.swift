//
//  ViewController.swift
//  Dicee
//
//  Created by Rodolfo Queiroz on 2018-05-14.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstDiceImageView: UIImageView!
    @IBOutlet weak var secondDiceImageView: UIImageView!
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDices()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDices()
    }
    
    func updateDices(){
        let randomDiceIndex1 = Int(arc4random_uniform(6))
        let randomDiceIndex2 = Int(arc4random_uniform(6))
        
        firstDiceImageView.image = UIImage(named: diceArray[randomDiceIndex1])
        secondDiceImageView.image = UIImage(named: diceArray[randomDiceIndex2])
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(motion == .motionShake){
            updateDices()
        }
    }
    
}

