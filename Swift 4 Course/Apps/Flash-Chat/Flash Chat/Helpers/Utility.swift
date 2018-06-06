//
//  Utility.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-03.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit

fileprivate func toViewController(viewController: UIViewController){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.alpha = 0
    appDelegate.window!.rootViewController = viewController
    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        appDelegate.window?.alpha = 1
    }, completion: nil)
}

fileprivate func changeStoryBoard(named storyboardName: String) {
    let startStoryBoard = UIStoryboard(name: storyboardName, bundle: nil)
    guard let rootVC = startStoryBoard.instantiateInitialViewController() else {
        print("Could not render tabbar view controller...")
        return
    }
    
    toViewController(viewController: rootVC)
}

func enterApp() {
    changeStoryBoard(named: "Main")
}

func leaveApp() {
    changeStoryBoard(named: "Start")
}

func isiPhoneX() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
}
