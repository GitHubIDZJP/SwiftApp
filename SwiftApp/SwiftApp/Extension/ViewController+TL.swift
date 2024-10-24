//
//  ViewController+TL.swift
//  JZMyLove
//
//  Created by yliao on 2022/5/16.
//

import UIKit

@available(iOS 13.0, *)
extension UIViewController {
    static var current:UIViewController? {
        if #available(iOS 13.0, *) {
            let delegate  = UIApplication.shared.delegate as? AppDelegate
        } else {
            // Fallback on earlier versions
        }
        var current = delegate.window!.rootViewController
        
        while (current?.presentedViewController != nil)  {
            current = (current?.presentedViewController)!
        }
        
        if let tabbar = current as? UITabBarController , tabbar.selectedViewController != nil {
            current = tabbar.selectedViewController
        }
        
        while let navi = current as? UINavigationController , navi.topViewController != nil  {
            current = navi.topViewController
        }
        return current
    }
}
