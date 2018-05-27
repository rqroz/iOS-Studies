//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let questions = QuestionBank()
    var currentQuestionIndex: Int = 0
    var pickedAnswer: Bool = false
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        let userGuess = sender.tag == 1 ? true : false
        checkAnswer(guess: userGuess, questionIndex: currentQuestionIndex)
        
        currentQuestionIndex += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        questionLabel.text = questions.list[currentQuestionIndex].questionText
        progressLabel.text = "\(currentQuestionIndex+1)/\(questions.list.count)"
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width/CGFloat(questions.list.count)) * CGFloat(currentQuestionIndex + 1)
    }

    func nextQuestion() {
        if currentQuestionIndex < questions.list.count {
            updateUI()
        }else{
            let alert = UIAlertController(title: "Awesome", message: "You finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer(guess: Bool, questionIndex: Int) {
        if guess == questions.list[questionIndex].answer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
        } else {
            ProgressHUD.showError("Wrong...")
        }
    }
    
    func startOver() {
        currentQuestionIndex = 0
        score = 0
        nextQuestion()
    }
    
}
