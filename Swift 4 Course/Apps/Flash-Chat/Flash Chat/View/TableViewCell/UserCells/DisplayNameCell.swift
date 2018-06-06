//
//  DisplayNameCell
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class DisplayNameCell: BaseTextFieldCell {
    override func setupViews() {
        super.setupViews()
        
        addConstraintsWithFormat(format: "H:|-22-[v0]-22-|", views: [textField])
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-|", views: [textField])
    }
}
