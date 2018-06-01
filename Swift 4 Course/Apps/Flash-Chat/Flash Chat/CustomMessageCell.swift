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
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: CachedImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    var message: Message? {
        didSet {
            senderUsername.text = message?.sender
            messageBody.text = message?.body
            avatarImageView.image = UIImage(named: "egg")
            
            if message?.sender == Auth.auth().currentUser?.email {
                avatarImageView.backgroundColor = UIColor.flatMint()
                messageBackground.backgroundColor = UIColor.flatSkyBlue()
            } else {
                avatarImageView.backgroundColor = UIColor.flatWatermelon()
                messageBackground.backgroundColor = UIColor.flatGray()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
        
    }


}
