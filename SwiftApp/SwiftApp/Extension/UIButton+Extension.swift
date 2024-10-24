//
//  UIButton+Extension.swift
//  TL
//
//  Created by mac on 2022/2/10.
//

import UIKit

//MARK: 调整图片image与标题title位置
extension UIButton {
    enum Positions { case top, left, bottom,bottomReturn, right }
    
    func adjustImageTitlePosition(_ position: Positions = .left, spacing: CGFloat) {
        self.sizeToFit()
        
        let imageWidth = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        
        let labelWidth = self.titleLabel?.frame.size.width
        let labelHeight = self.titleLabel?.frame.size.height
        
        switch position {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight! - spacing / 2, left: 0, bottom: 0, right: -labelWidth!)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight! - spacing / 2, right: 0)
            break
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing * 1.5, bottom: 0, right: 0)
            break
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight! - spacing / 2, right: -labelWidth!)
            titleEdgeInsets = UIEdgeInsets(top: -imageHeight! - spacing / 2, left: -imageWidth!, bottom: 0, right: 0)
            break
        case .bottomReturn:
            
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom:  -labelHeight! - spacing / 2, right: -labelWidth!)
            imageEdgeInsets = UIEdgeInsets(top: -imageHeight! - spacing / 2, left: -imageWidth!, bottom: 0, right: 0)
            break
       
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth! + spacing / 2, bottom: 0, right: -labelWidth! - spacing / 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth! - spacing / 2, bottom: 0, right: imageWidth! + spacing / 2)
            break
        }
    }
}

//MARK: 渐变背景
extension UIButton {
    @discardableResult
    func backgroundGradient<T: UIButton>(_ colours: [UIColor],
                                         _ isVertical: Bool = false,
                                         _ state: UIControl.State) -> T {
        let gradientLayer = CAGradientLayer()
        //几个颜色
        gradientLayer.colors = colours.map { $0.cgColor }
        //颜色的分界点
        gradientLayer.locations = [0.2,1.0]
        //开始
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        //结束,主要是控制渐变方向
        gradientLayer.endPoint  = isVertical == true ? CGPoint(x: 0.0, y: 1.0) : CGPoint(x: 1.0, y: 0)
        //多大区域
        gradientLayer.frame = self.bounds.isEmpty ? CGRect(x: 0, y: 0, width: 320, height: 30) : self.bounds
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            gradientLayer.render(in: context)
            
            let outputImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            setBackgroundImage(outputImage, for: state)
        }
        return self as! T
    }
}


typealias ActionBlock = ((UIButton)->Void)

extension UIButton {
    
    private struct AssociatedKeys {
        static var ActionBlock = "ActionBlock"
        static var ActionDelay = "ActionDelay"
    }
    
    /// 运行时关联
    private var actionBlock: ActionBlock? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ActionBlock, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ActionBlock) as? ActionBlock
        }
    }
    
    private var actionDelay: TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ActionDelay, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ActionDelay) as? TimeInterval ?? 0
        }
    }
    
    /// 点击回调
    @objc private func btnDelayClick(_ button: UIButton) {
        actionBlock?(button)
        isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + actionDelay) { [weak self] in
            print("恢复时间\(Date())")
            self?.isEnabled = true
        }
    }
    
    /// 添加点击事件
    func addAction(_ delay: TimeInterval = 0.5, action: @escaping ActionBlock) {
        addTarget(self, action: #selector(btnDelayClick(_:)) , for: .touchUpInside)
        actionDelay = delay
        actionBlock = action
    }
}


