//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class CustomMessageCell: UITableViewCell {
    
    var message: Message? {
        didSet {
            usernameLabel.text = message?.sender
            messageBody.text = message?.body
            
            if message?.sender == Auth.auth().currentUser?.email {
                messageBackgroundView.backgroundColor = UIColor.flatSkyBlue()
            } else {
                messageBackgroundView.backgroundColor = UIColor.flatGray()
            }
        }
    }
    
    let userImageView: CachedImageView = {
        let iv = CachedImageView()
        iv.loadImageWithString(imgString: "egg")
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
    
    let usernameLabel: UILabel = {
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentMode = .scaleToFill
        setupViews()
    }
    
    
    func setupViews(){
        setupBackgroundView()
        addSubview(userImageView)
        
        let iconSize = 1.5*DefaultSettings.standardIconSize
        
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: [messageBackgroundView])
        addConstraintsWithFormat(format: "V:|-8-[v0(\(iconSize))]", views: [userImageView])
        addConstraintsWithFormat(format: "H:|-8-[v0(\(iconSize))]-4-[v1]-8-|", views: [userImageView, messageBackgroundView])
    }
    
    func setupBackgroundView(){
        messageBackgroundView.addSubview(usernameLabel)
        messageBackgroundView.addSubview(messageBody)
        
        messageBackgroundView.addConstraintsWithFormat(format: "V:|-8-[v0]-4-[v1]-8-|", views: [usernameLabel, messageBody])
        messageBackgroundView.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: [usernameLabel])
        messageBackgroundView.addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: [messageBody])
        
        addSubview(messageBackgroundView)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
