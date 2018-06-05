//
//  Extensions.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit


extension UIView {
    func addConstraintsWithFormat(format: String, views: [UIView]) {
        var viewsDict = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)" //v1, v2, v3....
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
    
    func addConstraintToItem(view: UIView, related: UIView, attribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat){
        addConstraint(NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: related, attribute: attribute, multiplier: multiplier, constant: constant))
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension CachedImageView {
    convenience init(localImageName: String?, withBorder: Bool = false) {
        self.init(image: nil)
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
        
        if let imgName = localImageName {
            self.loadImageWithString(imgString: imgName)
        }
        
        if withBorder {
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 0.4
        }
    }
}
