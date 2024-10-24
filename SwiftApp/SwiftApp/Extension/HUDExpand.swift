//
//  HUDExpand.swift
//  JZMyLove
//
//  Created by yliao on 2022/5/21.
//

import UIKit
import MBProgressHUD
class HUDExpand: MBProgressHUD {
    
  @objc  static var sharedManager: HUDExpand {
        struct Static {
            static let instance : HUDExpand = HUDExpand()
        }
           return Static.instance
    }
    var mbp = MBProgressHUD()
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    func TemporaryText(text:String)  {
//        mbp?.mode = .annularDeterminate
        mbp = MBProgressHUD.init()
        mbp = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window as? UIView)!, animated: true)
        mbp.labelText = text
//        mbp?.removeFromSuperViewOnHide = false
//        let view =
//
//        view.addSubview(mbp!)
        
    }
    //文字提醒
    func TemporaryTextdetailsLabelText(text:String,detailsLabelText:String)  {
        //        mbp?.mode = .annularDeterminate
        mbp = MBProgressHUD.init()
        mbp = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window as? UIView)!, animated: true)
        mbp.labelText = text
        mbp.bezelView.color = .black
        mbp.contentColor = .white
        mbp.detailsLabelText = detailsLabelText
        mbp.mode = .text
        //        mbp?.removeFromSuperViewOnHide = false
        //        let view =
        //
        //        view.addSubview(mbp!)
      
    }
    func TemporaryactvText(text:String)  {
        //        mbp?.mode = .annularDeterminate
        mbp = MBProgressHUD.init()
        mbp = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window as? UIView)!, animated: true)
        mbp.labelText = text
        mbp.mode = .text
        //        mbp?.removeFromSuperViewOnHide = false
        //        let view =
        //
        //        view.addSubview(mbp!)
        
    }
    
    func hideMbp(delaye:Int)  {
        mbp.hide(true, afterDelay: TimeInterval(delaye))
    }
    
    //TODO: 菊花
    func TemporaryactvTextndeterminate()  {
        //        mbp?.mode = .annularDeterminate
        mbp = MBProgressHUD.init()
        mbp = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window as? UIView)!, animated: true)
        mbp.labelText = "正在请求请稍后"
        mbp.mode = .indeterminate
        mbp.bezelView.color = .black
        mbp.contentColor = .white
     
        //        mbp?.removeFromSuperViewOnHide = false
        //        let view =
        //
        //        view.addSubview(mbp!)
        
    }
    
    
}
