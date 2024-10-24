//
//  IQKeyboardManagerViewController.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import UIKit
import IQKeyboardManagerSwift
import SnapKit
class IQKeyboardManagerViewController: UIViewController {
    
    /*
     AppDelegata里全局开启就行
     IQKeyboardManager.shared.enable = true
     IQKeyboardManager.shared.enableAutoToolbar = true // 确保启用工具条
     IQKeyboardManager.shared.shouldResignOnTouchOutside = true // 点击空白区域隐藏键盘
     
     */
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
  //    self.navigationController?.setNavigationBarHidden(false, animated: true)
//        无需再开启
//        IQKeyboardManager.shared.enable = true
//        
//        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tf = UITextField.init(frame: CGRect(x: 50, y: 200, width: 100, height: 50))
        tf.borderStyle = .roundedRect
        tf.placeholder = "请输入文本"
        tf.backgroundColor = .red
        tf.font = UIFont.systemFont(ofSize: 16)
//        tf.clearButtonMode = .whileEditing // 添加清除按钮
//       tf.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tf)
                
                // 使用 SnapKit 设置约束
      
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//      禁用
//        IQKeyboardManager.shared.enable = false
    }

}
