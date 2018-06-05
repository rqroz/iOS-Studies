//
//  UserImageCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class UserImageCell: BaseTableViewCell {
    
    let userImageView: CachedImageView = CachedImageView(localImageName: "default-user-icon", withBorder: true)
    
    let helperLabel: UILabel = {
        let l = UILabel()
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        l.text = "Maybe it's time to update your profile picture?"
        return l
    }()
    
    override func setupViews() {
        addSubview(userImageView)
        addSubview(helperLabel)
        
        let imageSize: CGFloat = 3 * DefaultSettings.standardIconSize
        
        addConstraintsWithFormat(format: "V:|-22-[v0(\(imageSize))]-22-|", views: [userImageView])
        addConstraintsWithFormat(format: "V:|-22-[v0]-22-|", views: [helperLabel])
        addConstraintsWithFormat(format: "H:|-22-[v0(\(imageSize))]-24-[v1]-22-|", views: [userImageView, helperLabel])
        
        addConstraintToItem(view: userImageView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        userImageView.layer.cornerRadius = imageSize/2
    }

}
