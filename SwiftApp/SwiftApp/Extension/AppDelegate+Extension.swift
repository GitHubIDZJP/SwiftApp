//
//  AppDelegate+Extension.swift
//  JZMyLove
//
//  Created by yliao on 2022/5/19.
//

import Foundation
@available(iOS 13.0, *)
extension AppDelegate  {
   
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
            
            return WXApi.handleOpen(url, delegate: self)
            
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {

            return WXApi.handleOpen(url, delegate: self)
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
            
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
            
    }
    
    func onReq(_ req: BaseReq) {
            print("aaaaaaaaaaaaaa")
        }
        
        func onResp(_ resp: BaseResp) {
            
            if resp.isKind(of: SendAuthResp.self) {
                
                if resp.errCode == 0 {
                    
                    let _resp = resp as! SendAuthResp
                    if let code = _resp.code {
                      
//                          wxDelegate.loginSuccessByCode(code: code)
                    }
                  
                } else {
                    
                    print(resp.errStr)
                }
            }
        }
}
