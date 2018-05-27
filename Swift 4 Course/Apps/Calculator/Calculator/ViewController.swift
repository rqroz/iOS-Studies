//
//  ViewController.swift
//  Calculator
//
//  Created by Rodolfo Queiroz on 2018-05-26.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var answer: Float = 0
    var lastOperator: Float?
    var lastOperation: Int?
    
    var atStart: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func multipleNumberOperation(_ sender: UIButton) {
        guard let number = Float(numberLabel.text!) else { return }
        
        if sender.tag == 0 {
            equality(currentNumber: number)
        } else if sender.tag > 0 && sender.tag < 5 {
            let op = lastOperation ?? sender.tag
            performOperations(operationIdentifier: op, currentNumber: number)
            lastOperation = sender.tag
        }
    }
    
    func equality(currentNumber number: Float){
        if lastOperation == nil {
            answer = number
        } else {
            performOperations(operationIdentifier: lastOperation!, currentNumber: number)
        }
        
        lastOperator = nil
        lastOperation = nil
        atStart = true
    }
    
    func performOperations(operationIdentifier opID: Int, currentNumber number: Float){
        guard let prevNumber = lastOperator, lastOperator != nil else {
            lastOperator = number
            lastOperation = opID
            atStart = true
            return
        }
        
        switch opID {
        case 1: // Sum
            lastOperator = prevNumber + number
            break
        case 2: // Subtraction
            lastOperator = prevNumber - number
            break
        case 3: // Multiplication
            lastOperator = prevNumber * number
            break
        case 4: // Division
            lastOperator = prevNumber / number
            break
        default:
            break
        }
        
        answer = lastOperator ?? 0
        updateCalculator()
    }
    
    @IBAction func singleNumberOperation(_ sender: UIButton) {
        guard let number = Float(numberLabel.text!) else { return }
        
        switch sender.tag {
            case 0: // Reset
                resetCalculator()
                break
            case 1: // Change signal
                answer = -number
                updateCalculator()
                break
            case 2: // Percentage
                answer = number/100
                updateCalculator()
                break
            default:
                break
        }
    }
    
    @IBAction func numberClicked(_ sender: UIButton) {
        guard let text = numberLabel.text else { return }
        let appended = sender.tag == -1 ? "." : "\(sender.tag)"
        
        if (numberLabel.text == "0" && appended == "0") {
            return
        }else if atStart || numberLabel.text == "0" {
            numberLabel.text = appended
            atStart = false
        } else {
            numberLabel.text = text+appended
        }
    }
    
    func resetCalculator(){
        answer = 0
        lastOperator = nil
        lastOperation = nil
        updateCalculator()
    }
    
    func updateCalculator(){
        let ans = "\(answer)"
        let textParts = ans.split(separator: ".")
        if textParts.last == "0" {
            numberLabel.text = String(describing: textParts.first!)
        }else{
            numberLabel.text = ans
        }
        atStart = true
    }
}

