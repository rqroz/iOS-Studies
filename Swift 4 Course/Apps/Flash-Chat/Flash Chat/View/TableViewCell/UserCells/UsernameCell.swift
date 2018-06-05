//
//  UsernameCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class UsernameCell: BaseTableViewCell {
    let usernameLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    override func setupViews() {
        addSubview(usernameLabel)
        
        addConstraintsWithFormat(format: "H:|-22-[v0]-22-|", views: [usernameLabel])
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-|", views: [usernameLabel])
    }
}
