//
//  CachedImageView.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-01.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    var imageUrlString: String?
    
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
    
    func loadImageWithUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = DefaultSettings.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let imageToCache = UIImage(data: data!){
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    
                    DefaultSettings.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                }
            })
        }).resume()
    }
    
    func loadImageWithString(imgString: String, asTemplate: Bool = false){
        imageUrlString = imgString
        
        image = nil
        
        if let imageFromCache = DefaultSettings.imageCache.object(forKey: imgString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }else if let imageFromString = UIImage(named: imgString) {
            let imageToCache = asTemplate ? imageFromString.withRenderingMode(.alwaysTemplate) : imageFromString
            
            if self.imageUrlString == imgString {
                self.image = imageToCache
            }
            
            DefaultSettings.imageCache.setObject(imageToCache, forKey: imgString as AnyObject)
        }
    }
}
