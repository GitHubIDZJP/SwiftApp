//
//  globalConfig.swift
//  JZMyLove
//
//  Created by TonyJia on 2022/4/16.
//
import Foundation
import UIKit
import CoreGraphics

/**
 
 第一层:  创建 setupUI() 或者init  加style 和
 第二层:  写constraints
 第三层:  第三层 写业务逻辑 比如数据交互
 
 
 */

@available(iOS 13.0, *)
let delegate = UIApplication.shared.delegate as! AppDelegate
let globalButtonBgColor = colorFromRGB(r: 103, 8, 248, alpha: 1)
let gColor =  UIColor.color(hex:"#F1F1F1" )
let  globalColor:UIColor = colorFromRGB(r: 253, 251, 255, alpha: 1)
let  customNavY:CGFloat = 5
let  c_fontSize = UIFont(name: "Helvetica-Bold", size: 18*kRate)

let separatorColor:UIColor =    colorFromRGB(r: 230, 230, 230, alpha: 1)
let tabColor:UIColor =   colorFromRGB(r: 249, 249, 249, alpha: 1)
//我的页面滚动视图内容大小
let contentSizeISX:CGFloat = isIPhoneX ? 1.05 :  1.15
let globalSexBoy:String = "1"
let globalSexGirl:String = "2"
//TODO:判断我的设置界面cell是否设备X 
let MySettingCellDecideDeviceIsX:CGFloat  = iPhoneX ? 12 : 0
let MySettingFirstRowCellDecideISX:CGFloat = iPhoneX ? 5 : 0
let MyEditInfoFirstRowCellDecideISX:CGFloat = iPhoneX ? 5 : 2
let MyInfoFillFirstRowCellDecideISX:CGFloat = iPhoneX ? 5 : 2
//判断性别
enum SexType {
    case Boy
    case Girl
}



enum listInterpretation: Int {
    case firstCell, secondCell
}

extension UIButton {
      // 定义关联的Key
      private struct UIButtonKeys {
         static var clickKey = "UIButton+Extension+ActionKey"
      }
      
      func addActionWithBlock(_ closure: @escaping (_ sender:UIButton)->()) {
          //把闭包作为一个值 先保存起来
         objc_setAssociatedObject(self, &UIButtonKeys.clickKey, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
          //给按钮添加传统的点击事件，调用写好的方法
         self.addTarget(self, action: #selector(my_ActionForTapGesture), for: .touchUpInside)
      }
      @objc private func my_ActionForTapGesture() {
         //获取闭包值
         let obj = objc_getAssociatedObject(self, &UIButtonKeys.clickKey)
         if let action = obj as? (_ sender:UIButton)->() {
             //调用闭包
             action(self)
         }
      }
}
/**
 btn.addActionWithBlock { [weak self]  btn in
     
    
 }
 
 */


typealias BtnActionClick = (UIButton)->()

extension UIButton{

///  gei button 添加一个属性 用于记录点击tag
   private struct AssociatedKeys{
      static var actionKey = "actionKey"
   }
    
    @objc dynamic var actionDic: NSMutableDictionary? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let dic = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? NSDictionary{
                return NSMutableDictionary.init(dictionary: dic)
            }
            return nil
        }
    }

  @objc dynamic fileprivate func DIY_button_add(action:@escaping  BtnAction ,for controlEvents: UIControl.Event) {
        let eventStr = NSString.init(string: String.init(describing: controlEvents.rawValue))
        if let actions = self.actionDic {
            actions.setObject(action, forKey: eventStr)
            self.actionDic = actions
        }else{
            self.actionDic = NSMutableDictionary.init(object: action, forKey: eventStr)
        }
        
        switch controlEvents {
            case .touchUpInside:
                self.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
            case .touchUpOutside:
                self.addTarget(self, action: #selector(touchUpOutsideBtnAction), for: .touchUpOutside)
          
        default:
          return
        }
      }

      @objc fileprivate func touchUpInSideBtnAction(btn: UIButton) {
          if let actionDic = self.actionDic  {
            if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? BtnAction{
                  touchUpInSideAction(self)
               }
          }
      }

      @objc fileprivate func touchUpOutsideBtnAction(btn: UIButton) {
         if let actionDic = self.actionDic  {
           if let touchUpOutsideBtnAction = actionDic.object(forKey:   String.init(describing: UIControl.Event.touchUpOutside.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
         }
      }
   }




extension String {
    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}
/**
 调用:
 
 
 let range:Range = labelText.range(of: "高度")!
         let nsrange = labelText.nsRange(from: range)

         let mutableAttribute = NSMutableAttributedString(attributedString: label.attributedText!)
         mutableAttribute.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.     : UI    .init(name: "PingFang SC", size: 14)!], range: nsrange)
         
         label.attributedText = mutableAttribute

 
 
 */
//设置渐变色
func attributedtext(text:String,mainColor:UIColor,mainFont:CGFloat,mainText:String,subColor:UIColor,subFont:CGFloat,subText:String) ->NSMutableAttributedString {

  let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:text)

  let str = NSString(string: text)

      let theRange = str.range(of: mainText)

      attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: mainColor, range: theRange)

    //  attrstring.addAttribute(NSAttributedString.Key.    , value:UI    .system    (ofSize: main    ), range: theRange)

  
  
  
  attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: mainColor, range: theRange)
  
  
  
      let theSubRange = str.range(of: subText)

      attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: subColor, range: theSubRange)

     attrstring.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: subFont), range: theSubRange)

      return attrstring

   }

//设置渐变色style
func attributedtextStyle(text:String,mainColor:UIColor,mainFont:CGFloat, mainFontName:String,mainText:String,subColor:UIColor,subFont:CGFloat,subFontName:String,subText:String,lastColor:UIColor,lastFont:CGFloat,lastFontName:String,lastText:String) ->NSMutableAttributedString {

  let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:text)

  let str = NSString(string: text)

      let theRange = str.range(of: mainText)

      attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: mainColor, range: theRange)

    //  attrstring.addAttribute(NSAttributedString.Key.    , value:UI    .system    (ofSize: main    ), range: theRange)

  
  
  
  attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: mainColor, range: theRange)
  
  
  
      let theSubRange = str.range(of: subText)

      attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: subColor, range: theSubRange)

     attrstring.addAttribute(NSAttributedString.Key.font, value:UIFont(name: subFontName, size: subFont), range: theSubRange)

      return attrstring

   }
/**
 label.attributedText=attributedtext(text:"1234567890", mainColor:color_333333, mainFont:12, mainText:"12345，", subColor:color_fb464c, subfont:12, subText:"67890")
 */

//创建分类给UIView快速修改frame

extension UILabel {

    public var ld_x: CGFloat {

        get {
            return self.frame.origin.x
        }

        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.origin.x = newVal
            self.frame = ld_frame

        }

    }


    public var ld_y: CGFloat {

        get {
            return self.frame.origin.y
        }
        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.origin.y = newVal
            self.frame = ld_frame

        }

    }

    public var ld_width: CGFloat {

        get {
            return self.frame.size.width
        }

        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.size.width = newVal
            self.frame = ld_frame

        }

    }

    public var ld_height: CGFloat {

        get {
            return self.frame.size.height
        }

        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.size.height = newVal
            self.frame = ld_frame

        }

    }

    public var ld_size: CGSize {

        get {
            return self.frame.size
        }

        set(newVal) {
            var ld_frame: CGRect = self.frame
            ld_frame.size = newVal
            self.frame = ld_frame

        }

    }

    public var ld_centerX: CGFloat {

        get {
            return self.center.x
        }

        set(newVal) {
            var ld_center: CGPoint = self.center
            ld_center.x = newVal
            self.center = ld_center

        }

    }

    public var ld_centerY: CGFloat {

        get {
            return self.center.y
        }

        set(newVal) {
            var ld_center: CGPoint = self.center
            ld_center.y = newVal
            self.center = ld_center

        }

    }

}
///**
// 调用:  确实有效果 前提是得必须是UIView控件
// let view: UIView = UIView()
// view.ld_x = 10
// view.ld_y = 10
//
// */



extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    func imageWithColor() ->UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.setFillColor(self.cgColor)
        ctx!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func color(hex:String) ->UIColor{
        var cstr = hex.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
    }
    
    
}
//label高度自适应:label设置的属性要和你的label一致， 需要适应高度:宽度设置固定,高度0， 适应宽:高度固定,宽度0
func itemSize(title: String, height: CGFloat) ->CGSize{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = title
        label.textAlignment = .center
        label.sizeToFit()
        return CGSize(width: label.bounds.size.width + 10, height: height)
}
//设置颜色16进制:  .color(hex: "FFFFFF")

 
extension UIButton {
    
    /// 图片在右位置
    /// - Parameter spacing: 间距
    func iconInRight(with spacing: CGFloat) {
        let img_w = self.imageView?.frame.size.width ?? 0
        let title_w = self.titleLabel?.frame.size.width ?? 0
        
      self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(img_w+spacing / 2.0), bottom: 0, right: (img_w+spacing / 2.0))
      self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (title_w+spacing / 2.0), bottom: 0, right: -(title_w+spacing / 2.0))
    }
    
    /// 图片在左位置
    /// - Parameter spacing: 间距
    func iconInLeft(spacing: CGFloat) {
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2.0, bottom: 0, right: -spacing / 2.0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2.0, bottom: 0, right: spacing / 2.0)
    }
    
    /// 图片在上面
    /// - Parameter spacing: 间距
    func iconInTop(spacing: CGFloat) {
        let img_W = self.imageView?.frame.size.width ?? 0
        let img_H = self.imageView?.frame.size.height ?? 0
        let tit_W = self.titleLabel?.frame.size.width ?? 0
        let tit_H = self.titleLabel?.frame.size.height ?? 0
        
        self.titleEdgeInsets = UIEdgeInsets(top: (tit_H / 2 + spacing / 2), left: -(img_W / 2), bottom: -(tit_H / 2 + spacing / 2), right: (img_W / 2))
        self.imageEdgeInsets = UIEdgeInsets(top: -(img_H / 2 + spacing / 2), left: (tit_W / 2), bottom: (img_H / 2 + spacing / 2), right: -(tit_W / 2))
    }
    
    /// 图片在 下面
    /// - Parameter spacing: 间距
    func iconInBottom(spacing: CGFloat) {
        let img_W = self.imageView?.frame.size.width ?? 0
        let img_H = self.imageView?.frame.size.height ?? 0
        let tit_W = self.titleLabel?.frame.size.width ?? 0
        let tit_H = self.titleLabel?.frame.size.height ?? 0
        
        self.titleEdgeInsets = UIEdgeInsets(top: -(tit_H / 2 + spacing / 2), left: -(img_W / 2), bottom: (tit_H / 2 + spacing / 2), right: (img_W / 2))
        self.imageEdgeInsets = UIEdgeInsets(top: (img_H / 2 + spacing / 2), left: (tit_W / 2), bottom: -(img_H / 2 + spacing / 2), right: -(tit_W / 2))
    }
}
//设置阴影
/** 4周阴影
 setAroundShadow(view: 要设置阴影的视图变量名, sColor: UIColor.red, offset: CGSize(width: 0, height: 0), opacity: 2, radius: 5)
 
 */
func setAroundShadow(view:UIView,sColor:UIColor,offset:CGSize,
                     opacity:Float,radius:CGFloat,cornerRadius:CGFloat) {
        //设置阴影颜色
        view.layer.shadowColor = sColor.cgColor
        //设置透明度
        view.layer.shadowOpacity = opacity
        //设置阴影半径
        view.layer.shadowRadius = radius
        //设置阴影偏移量
        view.layer.shadowOffset = offset
       //设置圆角效果
        view.layer.cornerRadius = cornerRadius
    }
/**
 设置顶边阴影:
 
 主要是设置topY值:
  0和负数为顶阴影
   5- 40为下阴影
 setTopShadow(view: nr, sColor: UIColor.purple, offset: CGSize(width: 0, height: 0.5), opacity: 0.6, radius: 1,topY: -3,cornerRadius:5)
 */
func setTopShadow(view:UIView,sColor:UIColor,offset:CGSize,
                  opacity:Float,radius:CGFloat,topY:CGFloat,cornerRadius:CGFloat) {
      //设置阴影颜色
      view.layer.shadowColor = sColor.cgColor
      //设置透明度
      view.layer.shadowOpacity = opacity
      //设置阴影半径
      view.layer.shadowRadius = radius
      //设置阴影偏移量
      view.layer.shadowOffset = offset
      view.layer.cornerRadius = cornerRadius
  //顶边阴影
  let shadowPathWidth = view.layer.shadowRadius
  let shadowRect:CGRect = CGRect(x: 0, y: topY, width: view.bounds.size.width, height: shadowPathWidth)
  let path:UIBezierPath = UIBezierPath(rect: shadowRect)
  view.layer.shadowPath = path.cgPath
}
//func setRoundedCorners
extension UIApplication {
class var statusBarBackgroundColor: UIColor? {
 get {
        if #available(iOS 13.0, *) {
          let tag = 987654321

          if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                    return statusBar.backgroundColor
                }
                    let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            return statusBar.backgroundColor
                } else {
                    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
                    return statusBar.backgroundColor
                }
    }
    set {
        if #available(iOS 13.0, *) {
            let tag = 987654321

            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                statusBar.backgroundColor = newValue
            } else {
                let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                    statusBar.backgroundColor = newValue
                }
                statusBar.tag = tag
                UIApplication.shared.keyWindow?.addSubview(statusBar)
            }
        } else {
                    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
                    if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                        statusBar.backgroundColor = newValue
                    }
                }
    }
   }
}




/**
 设置view渐变色
 let layer = CAGradientLayer()
 layer.frame = underline.layer.bounds  //view.bounds
 ///设置颜色
 layer.colors = [UIColor.white.cgColor,UIColor.color(hex: "#6708F8").cgColor]

 ///设置颜色渐变的位置 （我这里是横向 中间点开始变化）
 layer.locations = [0,1]
 ///开始的坐标点
 layer.startPoint = CGPoint(x: 1, y: 0.3)
 ///结束的坐标点
 layer.endPoint = CGPoint(x: 0.7, y: 0.1)
 underline.layer.addSublayer(layer)
 
 */
