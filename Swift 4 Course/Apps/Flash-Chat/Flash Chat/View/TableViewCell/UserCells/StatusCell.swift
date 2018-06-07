//
//  StatusCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-06.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class StatusCell: BaseTextFieldCell {
    let statusLabel: UILabel = {
        let l = UILabel()
        l.text = "STATUS"
        l.font = .systemFont(ofSize: 14)
        l.textColor = .gray
        return l
    }()
    
    override func setupViews() {
        super.setupViews()
        maxCharachtersAllowed = 40
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.groupTableViewBackground
        
        addSubview(separatorView)
        
        separatorView.addSubview(statusLabel)
        separatorView.addConstraintsWithFormat(format: "H:|-22-[v0]-22-|", views: [statusLabel])
        separatorView.addConstraintsWithFormat(format: "V:[v0]-4-|", views: [statusLabel])
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: [separatorView])
        addConstraintsWithFormat(format: "H:|-22-[v0]-22-|", views: [textField])
        addConstraintsWithFormat(format: "V:|-[v0(40)]-12-[v1]-12-|", views: [separatorView, textField])
    }
}
