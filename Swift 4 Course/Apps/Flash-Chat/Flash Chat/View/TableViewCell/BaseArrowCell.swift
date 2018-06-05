//
//  BaseArrowCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-05.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class BaseArrowCell: BaseTableViewCell {
    let arrowImageView: CachedImageView = {
        let iv = CachedImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.loadImageWithString(imgString: "arrow-right", asTemplate: true)
        iv.tintColor = UIColor.flatGray()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
}
