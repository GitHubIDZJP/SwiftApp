//
//  UIView+EXtension.swift
//  JZMyLove
//
//  Created by yliao on 2022/5/21.
//

import Foundation
//TODO: 获取当前控制器
extension UIView {
    func viewController(Viewself:Any)->UIViewController? {
        var nextResponder: UIResponder? = Viewself as? UIResponder
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        return nil
    }
    
}

