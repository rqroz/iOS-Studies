//
//  UserConfigCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase

class UserConfigCell: BaseArrowCell {
    
    var user: User? {
        didSet {
            if user == nil { return }
            
            usernameLabel.text = user!.email
            if let imgUrl = user!.photoURL {
                userImageView.loadImageWithUrlString(urlString: imgUrl.absoluteString)
            }
        }
    }
    
    let userImageView: CachedImageView = CachedImageView(localImageName: "default-user-icon", withBorder: true)
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Username Lastname"
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.text = "My status goes here"
        return label
    }()
    
    override func setupViews() {
        let containerView = UIView()
        containerView.addSubview(usernameLabel)
        containerView.addSubview(statusLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0]|", views: [usernameLabel])
        containerView.addConstraintsWithFormat(format: "H:|[v0]|", views: [statusLabel])
        containerView.addConstraintsWithFormat(format: "V:|[v0]-8-[v1]|", views: [usernameLabel, statusLabel])
        
        addSubview(containerView)
        addSubview(userImageView)
        addSubview(arrowImageView)
        
        let imgSize: CGFloat = 3*DefaultSettings.standardIconSize
        userImageView.layer.cornerRadius = imgSize/2
        
        let arrowSize: CGFloat = 1.5*DefaultSettings.standardIconSize
        
        addConstraintsWithFormat(format: "H:|-12-[v0(\(imgSize))]-16-[v1]-12-[v2(\(arrowSize))]-4-|", views: [userImageView, containerView, arrowImageView])
        addConstraintsWithFormat(format: "V:|-[v0(\(imgSize))]-|", views: [userImageView])
        
        
        addConstraintToItem(view: userImageView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraintToItem(view: containerView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraintToItem(view: arrowImageView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
    }
}
