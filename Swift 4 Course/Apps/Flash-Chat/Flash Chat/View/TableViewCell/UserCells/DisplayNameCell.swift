//
//  DisplayNameCell
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class DisplayNameCell: BaseTableViewCell {
    var displayName: String? {
        didSet {
            textFieldView.textField.text = displayName
            textFieldView.updateRightView()
        }
    }
    
    var textFieldView: TextFieldView = TextFieldView()
    
    override func setupViews() {
        addSubview(textFieldView)
        
        addConstraintsWithFormat(format: "H:|-22-[v0]-22-|", views: [textFieldView])
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-|", views: [textFieldView])
    }
}
