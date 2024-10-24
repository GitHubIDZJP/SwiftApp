//
//  Global.swift
//  TL
//
//  Created by mac on 2022/2/8.
//

import Foundation
import UIKit

////MARK: 网易易盾的key
//let WYYBusinessid = "7685d479158e43d492fc1936c40be593"
////MARK: 高德地图key
//let TL_AMapServices = "c34bbf7e9729f29b5fe1429717523c9d"
////MARK: 微信key、id
//let WeChat_APPId = "wxfa6e015ea5b1ebf4"
//let WeChat_APPSecret = "ee4109d843ba99dad07cca6d50441219"
///// 通用链接
//let universalLink  = "https://prod.app.itianliao.com/apple-app-site-association"
///// 用户协议web链接地址
//let userAgreementWebAddress: String = "https://app.itianliao.com/login/static/userAgreement.html/"
///// 隐私政策web链接地址
//let privacyPolicyWebAddress: String = "https://app.itianliao.com/login/static/userPrivacy.html/"
///// 天聊社区自律公约
//let disciplineWebAddress: String = "http://prod.app.itianliao.com/login/static/selfDiscipline.html"
/////充值协议
//let rechageAgreementWebAddress: String = "http://prod.app.itianliao.com/login/static/topUpAgreement.html"

// 获取开发环境
var isDebugNet: Int{
    var isDebugNet:Int = 0 // debug模式 默认生产环境
    if UserDefaults.standard.object(forKey: "isDebugNet") == nil{
        UserDefaults.standard.set(isDebugNet, forKey: "isDebugNet")
    }else{
        isDebugNet = UserDefaults.standard.object(forKey: "isDebugNet") as! Int
    }
    return isDebugNet
}


// 0：开发 1：预发 2：正式
/// 友盟key
/// 测试：612c50234bede245d9eed0f8
/// 预发：623460350615d7572d31c44a
/// 正式：623e83014276ad3e606eadcb
//var UMKey: String {
//    var key = "623e83014276ad3e606eadcb"
//#if DEBUG
//
//    if isDebugNet == 0{
//        key = "612c50234bede245d9eed0f8"//测试
//    }else if isDebugNet == 1{
//        key = "623460350615d7572d31c44a"//预发
//    }else{
//        key = "623e83014276ad3e606eadcb"//正式
//    }
//#endif
//    return key
//}


// 0：开发 1：预发 2：正式
/// 融云的Key
/// 测试：3argexb63g1ae
/// 预发：x18ywvqfxybqc
/// 正式：m7ua80gbmz3jm
//var RC_key: String {
//    var key = "m7ua80gbmz3jm"
//#if DEBUG
//
//    if isDebugNet == 0{
//        key = "3argexb63g1ae"//测试
//    }else if isDebugNet == 1{
//        key = "x18ywvqfxybqc"//预发
//    }else{
//        key = "m7ua80gbmz3jm"//正式
//    }
//#endif
//    return key
//}


//MARK: 常用的类库信息,全局引入
@_exported import SnapKit
@_exported import RswiftResources

@_exported import Then
@_exported import RxSwift
@_exported import RxCocoa
@_exported import Reusable
@_exported import HandyJSON
@_exported import SwiftyBeaver
@_exported import Lottie
@_exported import TZImagePickerController
@_exported import IQKeyboardManagerSwift

//MARK: 全局常量
let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height

/// 状态栏高度
/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)
var kStatusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return statusManager?.statusBarFrame.height ?? 20.0
    }
    return  UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
}

// 导航栏高度
let kNavigationBar_Height = 44.0

// 状态栏 + 导航栏 的高度
let kNavigationBar_Status_Height =  ( Int(kStatusBarHeight) + Int(kNavigationBar_Height) )

///底部tabbar 高度
let kTabBar_Height = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49

/// iphoneX底部适配间距
let kiPhoneXAdaptBottomSpace =  34.0

/// 有刘海机型
let iPhoneX = UIApplication.shared.statusBarFrame.size.height > 20 ? true : false

//屏幕高度系数（iPhoneX为基准标注）
let kRate:CGFloat = CGFloat(UIScreen.main.bounds.size.height/812.0)
//屏幕宽度度系数（iPhoneX为基准标注）
let kRateWith:CGFloat = CGFloat(UIScreen.main.bounds.size.width/375.0)
/// 屏幕分辨率比例
///scale=绝对长度比(point/pixel)=单位长度内的数量比(pixel/point)
let kScreenScale = UIScreen.main.scale

// 设备名称
let sysName = UIDevice.current.systemName

// 是否安装微信
let kWXAppInstalled:Bool = UIApplication.shared.canOpenURL(URL.init(string: "wechat://")!)

// 判断机型
var isIphoneX: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
        || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

public extension UIDevice {
    
    // 获取设备系统
    var versionName: String {
        return  UIDevice.current.systemVersion
    }
    
    /// 获取设备名称
    var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }

    switch identifier {
    case "iPod1,1":  return "iPod Touch 1"
    case "iPod2,1":  return "iPod Touch 2"
    case "iPod3,1":  return "iPod Touch 3"
    case "iPod4,1":  return "iPod Touch 4"
    case "iPod5,1":  return "iPod Touch (5 Gen)"
    case "iPod7,1":   return "iPod Touch 6"

    case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
    case "iPhone4,1":  return "iPhone 4s"
    case "iPhone5,1":   return "iPhone 5"
    case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
    case "iPhone5,3":  return "iPhone 5c (GSM)"
    case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
    case "iPhone6,1":  return "iPhone 5s (GSM)"
    case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
    case "iPhone7,2":  return "iPhone 6"
    case "iPhone7,1":  return "iPhone 6 Plus"
    case "iPhone8,1":  return "iPhone 6s"
    case "iPhone8,2":  return "iPhone 6s Plus"
    case "iPhone8,4":  return "iPhone SE"
    case "iPhone9,1":   return "国行、日版、港行iPhone 7"
    case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
    case "iPhone9,3":  return "美版、台版iPhone 7"
    case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
    case "iPhone10,1","iPhone10,4":   return "iPhone 8"
    case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
    case "iPhone10,3","iPhone10,6":   return "iPhone X"

    case "iPad1,1":   return "iPad"
    case "iPad1,2":   return "iPad 3G"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
    case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
    case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
    case "iPad5,3", "iPad5,4":   return "iPad Air 2"
    case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
    case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
    case "AppleTV2,1":  return "Apple TV 2"
    case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
    case "AppleTV5,3":   return "Apple TV 4"
    case "i386", "x86_64":   return "Simulator"
    default:  return identifier
    }
    }
}
