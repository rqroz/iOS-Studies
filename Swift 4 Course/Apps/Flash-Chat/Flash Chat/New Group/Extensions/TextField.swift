//
//  TextField.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

extension UITextField {
    //Adds a 1 point border to the bottom of a UITextField
    func addBottomBorder(color: UIColor? = nil){
        let border = CALayer()
        let borderWidth = CGFloat(1)
        if color != nil {
            border.borderColor = color!.cgColor
        }else{
            border.borderColor = UIColor.darkGray.cgColor
        }
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        
        self.layer.addSublayer(border)
    }
    
    func setDefaults() {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.layer.masksToBounds = true
    }
}
