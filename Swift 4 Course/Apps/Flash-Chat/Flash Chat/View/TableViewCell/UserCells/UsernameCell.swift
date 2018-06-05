//
//  UsernameCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class UsernameCell: BaseTableViewCell {
    var username: String? {
        didSet {
            textField.text = username
            updateRightView()
        }
    }
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.setDefaults()
        tf.isEnabled = false
        tf.rightViewMode = .whileEditing
        return tf
    }()
    
    private let rightTextFieldView: UILabel = {
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        l.textColor = .lightGray
        return l
    }()
    
    override func setupViews() {
        addSubview(textField)
        
        addConstraintsWithFormat(format: "H:|-22-[v0]-22-|", views: [textField])
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-|", views: [textField])
        
        textField.rightView = rightTextFieldView
        textField.addTarget(self, action: #selector(updateRightView), for: .editingChanged)
    }
    
    @objc func updateRightView() {
        let charactersTyped: Int = textField.text?.count ?? 0
        let charachtersAllowed: Int = 30
        rightTextFieldView.text = "\(charachtersAllowed - charactersTyped)"
    }
    
    func enableTextField() {
        textField.isEnabled = true
        textField.addBottomBorder(color: .gray)
        textField.becomeFirstResponder()
    }
}
