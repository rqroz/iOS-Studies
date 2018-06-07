//
//  BaseInfoCell.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-07.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//


import UIKit

class BaseInfoCell: BaseTableViewCell {
    let cachedImageView: CachedImageView = CachedImageView(localImageName: "default-user-icon", withBorder: true)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Title Here"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.text = "Description here"
        return label
    }()
    
    override func setupViews() {
        let containerView = UIView()
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0]|", views: [titleLabel])
        containerView.addConstraintsWithFormat(format: "H:|[v0]|", views: [descriptionLabel])
        containerView.addConstraintsWithFormat(format: "V:|[v0]-8-[v1]|", views: [titleLabel, descriptionLabel])
        
        addSubview(containerView)
        addSubview(cachedImageView)
        
        let imgSize: CGFloat = 3*DefaultSettings.standardIconSize
        cachedImageView.layer.cornerRadius = imgSize/2
        
        addConstraintsWithFormat(format: "H:|-12-[v0(\(imgSize))]-16-[v1]-12-|", views: [cachedImageView, containerView])
        addConstraintsWithFormat(format: "V:|-[v0(\(imgSize))]-|", views: [cachedImageView])
        
        
        addConstraintToItem(view: cachedImageView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraintToItem(view: containerView, related: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        accessoryType = .disclosureIndicator
    }
}
