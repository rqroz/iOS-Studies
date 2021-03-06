//
//  ChatMessageCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatMessageCell: UITableViewCell {
    var message: Message? {
        didSet {
            displayNameLabel.text = message?.sender
            messageBody.text = message?.body
            
            let anotherUser = message?.sender != Auth.auth().currentUser?.email
            setupViews(anotherUser: anotherUser)
        }
    }
    
    let userImageView: CachedImageView = {
        let iv = CachedImageView()
        iv.loadImageWithString(imgString: "default-user-icon")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let messageBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.layer.cornerRadius = 5
        return v
    }()
    
    let displayNameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor.flatWhite()
        l.sizeToFit()
        return l
    }()
    
    let messageBody: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17)
        l.textColor = .white
        l.numberOfLines = 0 
        return l
    }()
    
    func setupViews(anotherUser: Bool){
        subviews.forEach({ $0.removeFromSuperview() }) // Removes all the subviews in order to change the layout
        
        setupBackgroundView()
        addSubview(userImageView)
        
        let iconSize = 2*DefaultSettings.standardIconSize
        let padding = iconSize + 2 * 14 // 14 = 8 + 6 (paddings used in horizontal constraints bellow)
        
        userImageView.layer.cornerRadius = iconSize/2
        
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: [messageBackgroundView])
        addConstraintsWithFormat(format: "V:|-8-[v0(\(iconSize))]", views: [userImageView])
        
        if anotherUser { // Avatar on left
            addConstraintsWithFormat(format: "H:|-8-[v0(\(iconSize))]-6-[v1]-\(padding)-|", views: [userImageView, messageBackgroundView])
            messageBackgroundView.backgroundColor = UIColor.flatNavyBlue()
        } else { // Avatar on right
            addConstraintsWithFormat(format: "H:|-\(padding)-[v0]-6-[v1(\(iconSize))]-8-|", views: [messageBackgroundView, userImageView])
            messageBackgroundView.backgroundColor = UIColor.flatBlack()
        }
    }
    
    func setupBackgroundView(){
        messageBackgroundView.addSubview(displayNameLabel)
        messageBackgroundView.addSubview(messageBody)
        
        messageBackgroundView.addConstraintsWithFormat(format: "V:|-8-[v0]-4-[v1]-8-|", views: [displayNameLabel, messageBody])
        messageBackgroundView.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: [displayNameLabel])
        messageBackgroundView.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: [messageBody])
        
        addSubview(messageBackgroundView)
    }
}
