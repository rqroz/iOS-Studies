//
//  AppTabBarViewController.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-03.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

private enum TabIcons: String {
    case chat = "chat-icon"
    case config = "config-icon"
}

class AppTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    func configureTabBar() {
        let iconNames = [TabIcons.chat, TabIcons.config]
        for (index, vc) in viewControllers!.enumerated() {
            let icon = UIImage(named: iconNames[index].rawValue)
            let item = UITabBarItem(title: nil, image: icon, tag: index)
            item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            vc.tabBarItem = item
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
