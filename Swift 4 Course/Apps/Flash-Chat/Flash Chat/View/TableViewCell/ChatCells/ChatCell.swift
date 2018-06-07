//
//  ChatCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-07.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class ChatCell: BaseInfoCell {
    override func setupViews() {
        super.setupViews()
        changeImageSize(to: 2.5*DefaultSettings.standardIconSize)
        let separator: UIView = UIView()
        separator.backgroundColor = .lightGray
        addSubview(separator)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: [separator])
        addConstraintToItem(view: separator, related: titleLabel, attribute: .left, multiplier: 1, constant: -5)
        addConstraintToItem(view: separator, related: self, attribute: .right, multiplier: 1, constant: 0)
    }
}
