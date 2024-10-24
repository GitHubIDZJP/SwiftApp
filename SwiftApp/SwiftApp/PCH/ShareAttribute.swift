//
//  jzpch.swift
//  JZMyLove
//
//  Created by TonyJia on 2022/4/12.
//

import UIKit

//class jzpch: NSObject {
//
//}
import Foundation
//import HeaderClass

//import CodeViewSetMethod.swift

/*设备的高宽*/
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width

//开关
let APPVersionCode = "5"
//支付
let APPlayversion = "4"

let meiID = UIDevice.current.identifierForVendor?.uuid



let dversion = UIDevice.current.systemVersion

let dName = UIDevice.current.systemName

let cur_version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]

// iPhoneX设备
let isIPhoneX: Bool = ScreenHeight >= 812 ? true : false

// navigationBarHeight 刘海屏
let statusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height

// navigationBarHeight 底部栏
let bottomBarHeight : CGFloat = isIPhoneX ? 34 : 0
//状态栏高度
//let JH_StatusBarHeight (IS_iPhoneX ? 44.f : 20.f) oc版本
let JH_StatusBarHeight = isIPhoneX ? 44.0 : 20.0 //swift版本
// navigationBarHeight
let zero_value : CGFloat = isIPhoneX ? 88 : 64

let JH_NavBarHeight:CGFloat = isIPhoneX ? 88 : 64

// tabBarHeight
let tabBarHeight : CGFloat = isIPhoneX ? 49 + 34 : 49

// iPhoneX
let kisIPhoneX: Bool = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)

// iPhoneXR
let kisIPhoneXR: Bool = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) : false)

// iPhoneXS
let kisIPhoneXS: Bool = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) : false)


// iPhone4设备
let isIPhone4 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) < 568.0 ? true : false)
// iPhone5设备
let isIPhone5 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 568.0 ? true : false)
// iPhone6设备
let isIPhone6 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 667.0 ? true : false)
// iPhone6Plus设备
let isIPhone6P = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 736.0 ? true : false)

//当前app信息
let GetAppInfo = Bundle.main.infoDictionary
//获取当前版本号
let GetAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
//获取设备系统号
let GetSystemVersion = UIDevice.current.systemVersion
//iphone设备
let isIphone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false
//ipad设备
let isIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false

//屏幕宽高比例
//#define WidthInRatio(X) SecreenWidth/375*X
//#define HeightInRatio(X) SecreenHeight/667*X
func WidthRatio(_ X:CGFloat) -> CGFloat{
    return ScreenWidth/375*CGFloat(X)
}



func HeightInRatio(_ X:Int) -> CGFloat{
    return ScreenHeight/667*CGFloat(X)
}

//iPhone12
func WidthRatioUI(_ X:Int) -> CGFloat{
    return ScreenWidth/540*CGFloat(X)
}
func HeightInRatioUI(_ X:Int) -> CGFloat{
    return ScreenHeight/1170*CGFloat(X)
}

//轻灰背景
let lightGrayBackground = colorFromRGB(r: 238, 238, 237, alpha: 1)

//轻蓝色(标题)
//let segmentTitleColor = colorFromRGB(r: 114, 159, 192, alpha: 0.8)
//let segmentTitleColor = NSString.hexColor("3782C4")()!
//rgb颜色
func colorFromRGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}
//十六进制颜色
func COLORFROM16(h:Int) ->UIColor {
    return colorFromRGB(r: CGFloat(((h)>>16) & 0xFF), CGFloat(((h)>>8) & 0xFF), CGFloat((h) & 0xFF), alpha: 1.0)
}

//获取当前tableview全部cell
func cellsForTableView(tableview:UITableView)->Array<UITableViewCell>{
    let numbers = tableview.numberOfSections
    var cells:Array<UITableViewCell> = []
    for i in 0..<numbers{
        let rows = tableview.numberOfRows(inSection: i)
        for j in 0..<rows{
            let indexPath = IndexPath.init(row: j, section: i)
            cells.append(tableview.cellForRow(at: indexPath) ?? UITableViewCell())
        }
    }
    return cells
}

//获取当前collectionview全部cell
func cellsForCollectionView(collectionview:UICollectionView)->Array<UICollectionViewCell>{
    let numbers = collectionview.numberOfSections
    var cells:Array<UICollectionViewCell> = []
    for i in 0..<numbers{
        let rows = collectionview.numberOfItems(inSection: i)
        for j in 0..<rows{
            let indexPath = IndexPath.init(row: j, section: i)
            cells.append(collectionview.cellForItem(at: indexPath) ?? UICollectionViewCell())
        }
    }
    return cells
}

//获取当前section全部cell
func cellsForTableViewInSection(tableview:UITableView,section:Int)->Array<UITableViewCell>{
    var cells:Array<UITableViewCell> = []
        let rows = tableview.numberOfRows(inSection: section)
        for j in 0..<rows{
            let indexPath = IndexPath.init(row: j, section: section)
            cells.append(tableview.cellForRow(at: indexPath) ?? UITableViewCell())
        }
    return cells
}

//根据限定的宽度和UIFont，计算label的高度
func getLabelHeight(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat{
    let statusLabelText:NSString = labelStr as NSString
    let size = CGSize(width: width, height: 900)
    let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:AnyObject], context: nil).size
    return strSize.height
}

//字典转json字符串
func convertDictionaryToJSONString(dict:NSDictionary?)->String {
    let data = try? JSONSerialization.data(withJSONObject: dict!, options: JSONSerialization.WritingOptions.init(rawValue: 0))
    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    return jsonStr! as String
}

//json字符串转字典
func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
    let jsonData:Data = jsonString.data(using: .utf8)!
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}

//通过subviews来获取没有进入复用池，而且离屏的cell数组
func getCell(with tableview:UITableView)->Array<UITableViewCell>{
    var arr = [UITableViewCell]()
    guard tableview == tableview else { return [] }
    // 修改部分：
    for subview in tableview.subviews {
        if let cell = subview as? UITableViewCell {
            arr.append(cell)
        }
    }
    return arr
}

func ModelEnumerated(model:Any) -> NSDictionary{
    
    let mirrored_object = Mirror(reflecting: model)
    var dict:Dictionary<String,Any> = [:]
    for (_,attr) in mirrored_object.children.enumerated() {
//        if let value_name = attr.value {
        print("Attr:\(attr.label ?? "") = \(attr.value)")
        if (attr.value as? Int) != nil {
            let int = attr.value as! Int
            dict[String(attr.label!)] = int as Any
        }
        if (attr.value as? String) != nil {
            let str = attr.value as! String
            dict[String(attr.label!)] = str as Any
        }
        if (attr.value as? Double) != nil {
            let str = attr.value as! Double
            dict[String(attr.label!)] = str as Any
        }
//
//        }
    }
    return NSDictionary(dictionary: dict)
}

//感情状态
enum RBEmotionStatusType:String,CaseIterable {//情感状态(1:单身, 2:恋爱中, 3:已婚, 4:离异)
    
    case RBEmotionStatusSingle = "单身"
    case RBEmotionStatusInLove = "恋爱中"
    case RBEmotionStatusMarried = "已婚"
    case RBEmotionStatusDivorced = "离异"
    
}

//角色属性
enum RBPersonalityType:String,CaseIterable {//角色(0: 不限, 1: 0, 2: 偏0, 3: 0.5, 4: 1, 5: 偏1)
    
    case RBPersonalityNoLimited = "不限"
    case RBPersonalityZero = "0"
    case RBPersonalityAlmostZero = "偏0"
    case RBPersonalityHalf = "0.5"
    case RBPersonalityAlmostOne = "偏1"
    case RBPersonalityOne = "1"
}

//喜欢的类型
enum RBLikeStyleType:String,CaseIterable {//喜欢的类型(0: 不限, 1: 熊, 2: 大叔, 3: 小鲜肉, 4: 肌肉)（多选, 逗号分隔）
    
    case RBLikeStyleNoLimited = "不限"
    case RBLikeStyleBear = "熊"
    case RBLikeStyleUncle = "大叔"
    case RBLikeStyleFlesh = "小鲜肉"
    case RBLikeStyleMuscle = "肌肉"
}

//习惯爱好
enum RBHobbyType:String,CaseIterable {//兴趣爱好(1: 电影, 2: 图书, 3: 电视, 4: 音乐, 5: 宠物, 6: 餐厅, 7: 购物, 8: 看比赛, 9: 运动, 10: 酒吧, 11: 跳舞, 12: 游戏, 13: 旅游)（多选, 逗号分隔）
    case RBHobbyTypeMovie = "电影"
    case RBHobbyTypeBook = "图书"
    case RBHobbyTypeTV = "电视"
    case RBHobbyTypeMusic = "音乐"
    case RBHobbyTypePets = "宠物"
    case RBHobbyTypeRestaurant = "餐厅"
    case RBHobbyTypeShopping = "购物"
    case RBHobbyTypeWatchGame = "看比赛"
    case RBHobbyTypeSports = "运动"
    case RBHobbyTypeBar = "酒吧"
    case RBHobbyTypeDance = "跳舞"
    case RBHobbyTypePlayhGame = "游戏"
    case RBHobbyTypeTravel = "旅游"
    
}

//正在寻觅
enum RBLookForType:String,CaseIterable {//正在寻觅(1: 好友, 2: 调情, 3: 有趣, 4: 聊天, 5: 约会, 6: 聚会, 7: 关系)（多选, 逗号分隔）
    case RBLookForFriends = "朋友"
    case RBLookeForFliter = "调情"
    case RBLookForFun = "有趣"
    case RBLookForChat = "聊天"
    case RBLookForDating = "约会"
    case RBLookForMeeting = "聚会"
    case RBLookForRalationShip = "关系"
}
func saveUserInfo(keyName:String,valueName:Any){
    //下面2个方法都一样
    UserDefaults.standard.set(valueName, forKey: keyName)
    UserDefaults.standard.synchronize()
//    let defaults = UserDefaults.standard
//    defaults.setValue(valueName, forKey: keyName)
//    UserDefaults.standard.synchronize()
}
func getUserInfo(keyName:String) ->String{
    //下面2个方法都可以
    UserDefaults.standard.string(forKey: keyName  ) ?? ""
   // UserDefaults.standard.object(forKey: keyName) as! String
}

//部分圆角
//BottomAlertView
extension UIView{
    
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
  /*调用:
   设置圆角
   p.corner(byRoundingCorners: [.topLeft,.topRight] , radii: 10)
   */
}
public extension UIButton{
/** 部分圆角
 * - corners: 需要实现为圆角的角，可传入多个
 * - radii: 圆角半径
 */
func cornerButton(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = maskPath.cgPath
    self.layer.mask = maskLayer
  }

}

var expandSizeKey = "expandSizeKey"
 
extension UIButton {
    
    open func lzh_expandSize(size:CGFloat) {
        objc_setAssociatedObject(self, &expandSizeKey,size, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    
    private func expandRect() -> CGRect {
        let expandSize = objc_getAssociatedObject(self, &expandSizeKey)
        if (expandSize != nil) {
            return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height + 2*(expandSize as! CGFloat))
        }else{
            return bounds;
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRect =  expandRect()
        if (buttonRect.equalTo(bounds)) {
            return super.point(inside: point, with: event)
        }else{
            return buttonRect.contains(point)
        }
    }
}

/**
 调用
 let btn = UIButton()
 // 向四周扩展10像素的点击范围
 btn.lzh_expandSize(size: 10)
 
 */

//创建文件存沙盒
func creatNewFiles(name:String, fileBaseUrl:NSURL) -> String{
    let manager = FileManager.default
    let file = fileBaseUrl.appendingPathComponent(name)
       
    let exist = manager.fileExists(atPath: file!.path)
       if !exist {
        let createFilesSuccess = manager.createFile(atPath: file!.path, contents: nil, attributes: nil)
           print("文件创建结果: \(createFilesSuccess)")
       }
    return String(format: "%s", file! as CVarArg)
   }
/**
 读取文件
 
 - parameter name:        文件名
 - parameter fileBaseUrl: url
 
 - returns: 读取数据
 */


func readTheFlies(name:String , fileBaseUrl:NSURL) ->NSString{
    let file = fileBaseUrl.appendingPathComponent(name)
      //  print(file)
    let readHandler = try! FileHandle(forReadingFrom:file!)
       let data = readHandler.readDataToEndOfFile()
    let readString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
       return readString!
   }
//从View跳转到控制器
//class weak var weakSelf = self
//public func viewController()->UIViewController? {
//var nextResponder: UIResponder? = weakSelf
//repeat {
//    nextResponder = nextResponder?.next
//    if let viewController = nextResponder as? UIViewController {
//        return viewController
//    }
//} while nextResponder != nil
//return nil
//}
//中秋新加
extension UIColor {

    /// hexColor
    convenience init(hex: UInt32) {
        let r: CGFloat = CGFloat((hex & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
        let a: CGFloat = CGFloat(hex & 0x000000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// 创建一张纯色的图片的方法
    func toImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(self.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
}
/**
 调用:
 localView.backgroundColor = .init(hex: 8888) //MARK:设置背景色
 */

//获取当前的VC
public func getCurrentVcFrom(_ rootVc:UIViewController) -> UIViewController{
  var currentVc:UIViewController
  var rootCtr = rootVc
  if(rootCtr.presentedViewController != nil) {
    rootCtr = rootVc.presentedViewController!
  }
  if rootVc.isKind(of:UITabBarController.classForCoder()) {
    currentVc = getCurrentVcFrom((rootVc as! UITabBarController).selectedViewController!)
  }else if rootVc.isKind(of:UINavigationController.classForCoder()){
    currentVc = getCurrentVcFrom((rootVc as! UINavigationController).visibleViewController!)
  }else{
    currentVc = rootCtr
  }
  return currentVc
}


//优雅的为UIButton添加链式的Block点击事件
typealias BtnAction = (UIButton)->()

/**
  UIButton图像文字同时存在时---图像相对于文字的位置
  
  - top:    图像在上
  - left:   图像在左
  - right:  图像在右
  - bottom: 图像在下
  */

enum ButtonImageEdgeInsetsStyle{
  case top, left, right, bottom
}
extension UIButton{


  //按钮和文字设置上下位置
  /**
   调用:
   //对于如何给 UIView 添加 Block 手势事件也是这样思路
   clickBtn.addTouchUpInSideBtnAction{ _ in
       print("按下事件")
   }
   */
      func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat) {
          guard let imageV = imageView else { return }
          guard let titleL = titleLabel else { return }
          //获取图像的宽和高
          let imageWidth = imageV.frame.size.width
          let imageHeight = imageV.frame.size.height
          //获取文字的宽和高
        let labelWidth  = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height
          
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero  // UIEdgeInsets.zeroUIEdgeInsets.zero
          //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
          switch style {
          case .left:
              //正常状态--只不过加了个间距
              imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
              labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
          case .right:
              //切换位置--左文字右图像
              //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: CGFloat(-labelWidth) - space * 0.5)
              labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
          case .top:
              //切换位置--上图像下文字
              /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
               *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
              */
              imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
              labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
          case .bottom:
              //切换位置--下图像上文字
              /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
               *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
               */
              imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
              labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
          }
          self.titleEdgeInsets = labelEdgeInsets
          self.imageEdgeInsets = imageEdgeInsets
      }
  /**
   调用:
   leftBtn.imagePosition(at: .left, space: 10)
   rightBtn.imagePosition(at: .right, space: 10)
   topButton.imagePosition(at: .top, space: 10)
   bottomBtn.imagePosition(at: .bottom, space: 10)
   
   */
  
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

/**
 调用: .random()
 cell.backgroundColor = .random()
 
 */
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
func fetchCurrentTime() ->String{
    let todaysDate = NSDate()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    let DateInFormat = dateFormatter.string(from: todaysDate as Date)
     return DateInFormat
}



// MARK: -使用图像和文本生成上下排列的属性文本
extension NSAttributedString {

    //将图片属性以及文字属性用方法名传入
    class func imageTextInit(image: UIImage, imageW: CGFloat, imageH: CGFloat, labelTitle: String, fontSize: CGFloat, titleColor: UIColor, labelSpacing: CGFloat) -> NSAttributedString{

        //1.将图片转换成属性文本
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRectMake(0, 0, imageW, imageH)
        let imageText = NSAttributedString(attachment: attachment)

        //2.将标题转化为属性文本
        let titleDict = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize), NSAttributedString.Key.foregroundColor: titleColor]
        let text = NSAttributedString(string: labelTitle, attributes: titleDict)

        //3.换行文本可以让label长度不够时自动换行
        let spaceDict = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: labelSpacing)]
        let lineText = NSAttributedString(string: "\n\n", attributes: spaceDict)


        //4.合并属性文字
        let mutableAttr = NSMutableAttributedString(attributedString: imageText)
        mutableAttr.append(lineText)
        mutableAttr.append(text)

        //5.将属性文本返回
        return mutableAttr.copy() as! NSAttributedString
    }

}
func YWHomeListButton(imageName: String, titleName: String!) -> UIButton {

        //创建按钮类型为Custom
    let btn = UIButton(type: .custom)
        //获取我们刚得到的属性文本，直接是NSAttributedString的子方法了
    let attrStr = NSAttributedString.imageTextInit(image: UIImage(named: imageName)!, imageW:  ScreenWidth/8*3/2, imageH: ScreenWidth/8, labelTitle: titleName, fontSize: 12, titleColor: UIColor.lightGray, labelSpacing: 4)
        //设置按钮基本属性
    btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 0
       // btn.setAttributedTitle(attrStr, forState: .normal)
    btn.setAttributedTitle(attrStr, for: .normal)
        return btn

    }
extension UIButton {
    
    func layoutButton(imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        
        //重点： 修改imageEdgeInsets和labelEdgeInsets的相对位置的计算
        imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
        labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
        //break;
        
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}
