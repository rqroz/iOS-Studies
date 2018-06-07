//
//  UserConfigCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import Firebase

class UserConfigCell: BaseInfoCell {    
    var user: User? {
        didSet {
            if user == nil { return }
            
            titleLabel.text = user!.email
            if let imgUrl = user!.photoURL {
                cachedImageView.loadImageWithUrlString(urlString: imgUrl.absoluteString)
            }
        }
    }
}
