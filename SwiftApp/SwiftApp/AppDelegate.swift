import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true // 确保启用工具条
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true // 点击空白区域隐藏键盘

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        // 创建主视图控制器
//        let mainViewController = HandyJSONViewController()
        let mainViewController = RSwiftViewController()

        // 创建导航控制器并将主视图控制器作为根视图控制器
        let navigationController = UINavigationController(rootViewController: mainViewController)

        // 将导航控制器设置为窗口的根视图控制器
        window?.rootViewController = navigationController

        // 显示窗口
        window?.makeKeyAndVisible()
//        IQKeyboardManager.shared.enable = true
        return true
    }

    // MARK: - WXApiDelegate

//    func onReq(_ req: BaseReq) {
//        print("收到请求: \(req)")
//    }
//    
//    func onResp(_ resp: BaseResp) {
//        print("收到响应: \(resp)")
//        
//        if resp.isKind(of: SendAuthResp.self) {
//            if resp.errCode == 0 {
//                let _resp = resp as! SendAuthResp
//                if let code = _resp.code {
//                    // 处理登录成功的逻辑
//                }
//            } else {
//                print(resp.errStr)
//            }
//        }
//    }

    // MARK: UISceneSession Lifecycle (可选)

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // 处理丢弃的场景
//    }
}
