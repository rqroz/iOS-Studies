//
//  ConfigurationCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-03.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import ChameleonFramework

class ConfigurationCell: UITableViewCell {
    
    var configuration: ConfigurationItem? {
        didSet {
            if configuration != nil {
                configurationLabel.text = configuration!.text
                iconImageView.loadImageWithString(imgString: configuration!.iconName)
            }
        }
    }

    let iconImageView: CachedImageView = {
        let iv = CachedImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let configurationLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.textColor = .black
        l.sizeToFit()
        return l
    }()
    
    let arrowImageView: CachedImageView = {
        let iv = CachedImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.loadImageWithString(imgString: "arrow-right", asTemplate: true)
        iv.tintColor = UIColor.flatGray()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(iconImageView)
        addSubview(configurationLabel)
        addSubview(arrowImageView)
        
        let grayLine = UIView()
        grayLine.backgroundColor = UIColor.flatGray()
        addSubview(grayLine)
        
        let iconSize = DefaultSettings.standardIconSize
        
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1(0.5)]|", views: [configurationLabel, grayLine])
        addConstraintsWithFormat(format: "V:[v0(\(iconSize))]", views: [iconImageView])
        addConstraintsWithFormat(format: "V:[v0(\(iconSize))]", views: [arrowImageView])
        addConstraintsWithFormat(format: "H:|-8-[v0(\(iconSize))]-12-[v1]-12-[v2(\(iconSize))]-8-|", views: [iconImageView, configurationLabel, arrowImageView])
        
        addConstraintToItem(view: iconImageView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraintToItem(view: arrowImageView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        addConstraintToItem(view: grayLine, related: configurationLabel, attribute: .left, multiplier: 1, constant: 0)
        addConstraintToItem(view: grayLine, related: self, attribute: .right, multiplier: 1, constant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
