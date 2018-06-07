//
//  Utility.swift
//  Flash Chat
//
//  Created by Rodolfo Queiroz on 2018-06-03.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import UIKit
import SVProgressHUD

enum LoaderState {
    case on
    case off
}

fileprivate let blackViewTag: Int = 9876

fileprivate func addBlackView(toWindow window: UIWindow) {
    let blackView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.5)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tag = blackViewTag
        return v
    }()
    
    window.addSubview(blackView)
    window.addConstraintToItem(view: blackView, related: window, attribute: .top, multiplier: 1, constant: 0)
    window.addConstraintToItem(view: blackView, related: window, attribute: .right, multiplier: 1, constant: 0)
    window.addConstraintToItem(view: blackView, related: window, attribute: .left, multiplier: 1, constant: 0)
    window.addConstraintToItem(view: blackView, related: window, attribute: .bottom, multiplier: 1, constant: 0)
}

fileprivate func toViewController(viewController: UIViewController){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if appDelegate.window == nil { return }
    
    appDelegate.window!.alpha = 0
    appDelegate.window!.rootViewController = viewController
    addBlackView(toWindow: appDelegate.window!)
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

func toggleLoader(state: LoaderState) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    guard let window = appDelegate.window, let blackView = window.viewWithTag(blackViewTag) else {
        print("Could not resolve blackview...")
        return
    }
    
    if state == .on {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            blackView.alpha = 1
            SVProgressHUD.show()
        }, completion: nil)
    } else if state == .off {
        UIView.animate(withDuration: 0.5) {
            blackView.alpha = 0
            SVProgressHUD.dismiss()
        }
    }
}

func enterApp() {
    changeStoryBoard(named: "Main")
}

func leaveApp() {
    changeStoryBoard(named: "Start")
}
