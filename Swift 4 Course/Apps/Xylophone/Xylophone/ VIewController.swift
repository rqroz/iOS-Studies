//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var player: AVAudioPlayer!
    var soundFileNames = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        playSound(withName: soundFileNames[sender.tag - 1])
    }
    
    func playSound(withName soundFileName: String){
        let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "wav")!)
        
        do{
            player = try AVAudioPlayer(contentsOf: soundUrl)
            player.prepareToPlay()
            player.play()
        }catch{
            print(error.localizedDescription)
        }
    }
    
  

}

