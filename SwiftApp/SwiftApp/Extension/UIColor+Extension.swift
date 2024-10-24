//
//  UIColor+Extension.swift
//  TL
//
//  Created by mac on 2022/2/8.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0,  blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    /// 主题颜色
    static var themeColor: UIColor {
        return UIColor.hex("FFCC00")
    }
    
    static var title1: UIColor {
        return UIColor.hex("000000")
    }
    
    /// #FF6C1E
    static var orangeColor: UIColor {
        return UIColor.hex("FF6C1E")
    }
    
    /// #EF385C
    static var redColor: UIColor {
        return UIColor.hex("EF385C")
    }
    
    /// #0CB669
    static var grendColor: UIColor {
        return UIColor.hex("0CB669")
    }
    
    /// DEDEDE
    static var grayColor1: UIColor {
        return UIColor.hex("DEDEDE")
    }
    
    /// #9B9B9B
    static var grayColor2: UIColor {
        return UIColor.hex("9B9B9B")
    }
    
    /// #474747
    static var blackColor1: UIColor {
        return UIColor.hex("474747")
    }
    
    /// #161616
    static var blackColor2: UIColor {
        return UIColor.hex("161616")
    }
    
    /// #000000
    static var blackColor3: UIColor {
        return UIColor.hex("000000")
    }
    
    /// #51B3FF
    static var blueColor: UIColor {
        return UIColor.hex("51B3FF")
    }
    
    /// #00B9FF
    static var blueColor2: UIColor {
        return UIColor.hex("00B9FF")
    }
    
    /// #AE3DFF
    static var purpleColor: UIColor {
        return UIColor.hex("AE3DFF")
    }

    /// 随机颜色
//    static var random: UIColor {
//        return UIColor(r: arc4random_uniform(256),
//                       g: arc4random_uniform(256),
//                       b: arc4random_uniform(256))
//    }
    
    /// 十六进制颜色转换
    static func hex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    /// 把颜色转换成图片
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 颜色渐变 左到右
    /// - Parameters:
    ///   - width: 宽度
    class func gradient(leftColor: UIColor?, rightColor: UIColor?, width: CGFloat) -> UIColor {
        
        let size = CGSize(width: width, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let colors = [(leftColor ?? UIColor.blue).cgColor,(rightColor ?? UIColor.green).cgColor]
        let gradient = CGGradient(colorsSpace: colorspace, colors: colors as CFArray, locations: nil)!
        context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: image ?? UIImage())
    }
    
    /// 颜色渐变 上到下
    /// - Parameters:
    ///   - height: 高度
    class func gradient(topColor: UIColor?, bottomColor: UIColor?, height: CGFloat) -> UIColor {
        
        let size = CGSize(width: 1, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let colors = [(topColor ?? UIColor.blue).cgColor,(bottomColor ?? UIColor.green).cgColor]
        let gradient = CGGradient(colorsSpace: colorspace, colors: colors as CFArray, locations: nil)!
        context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: image ?? UIImage())
    }
}
