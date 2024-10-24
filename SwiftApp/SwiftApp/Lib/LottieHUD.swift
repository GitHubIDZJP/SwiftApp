/***
 加载动画：在数据加载或处理期间使用 Lottie 动画提升用户体验，避免界面看起来静止。
 按钮点击反馈：为按钮点击添加动画反馈，使界面更加生动和互动。
 用户引导：在首次使用应用时，通过动画引导用户完成操作，提高用户理解。
 教程动画：使用动画展示功能和操作步骤，帮助用户快速上手
 LOGO 动画：为品牌标志添加动态效果，使品牌形象更具吸引力。
 活动宣传：通过动画展示促销或活动信息，提高用户关注度
 游戏界面效果：在游戏界面中使用动画，增强视觉体验。
 特效：为游戏中的事件添加动画特效，增加趣味性和动态感
 动态表情：在社交应用中使用动画表情或贴纸，增加互动乐趣。
 分享内容：通过动画制作动态的分享内容，提升用户参与感
 教育动画：用于教育应用中，通过动画展示复杂概念，帮助学生理解。
 演示文稿：在演示或展示中使用动画，让内容更具吸引力。
 跨平台支持：Lottie 动画可以在多个平台（iOS、Android、Web）上使用，便于统一设计风格。
 */

/**
 使用场景:
 礼物动画
 送礼动画：在观众送出礼物时，使用 Lottie 动画展示礼物飞向主播的效果。这可以增强互动性，让观众感到自己的参与对直播内容的影响。
 动画效果：使用流畅的 Lottie 动画为礼物添加动态效果，例如礼物箱打开、礼物飘散等，增加视觉吸引力。
 2. 实时反馈
 礼物确认：在观众送出礼物后，通过 Lottie 动画提供即时反馈，比如显示“感谢你的礼物！”等信息。
 动态计数：显示送礼的数量或总价值时，可以使用 Lottie 动画让数字动态变化，吸引观众的目光。
 3. 界面装饰
 动态背景：在直播界面中使用 Lottie 动画作为背景，增加整体视觉效果。
 界面元素：为直播中的按钮、进度条等界面元素添加 Lottie 动画，提高整体的用户体验。
 4. 庆祝活动
 庆祝动画：在特定时刻（如达到送礼目标或重大时刻）使用 Lottie 动画进行庆祝，如烟花、彩带等效果，增加节日气氛。
 5. 品牌推广
 品牌礼物：在直播中推广品牌时，可以使用 Lottie 动画展示品牌相关的礼物，提升品牌形象和认知度。
 结论
 使用 Lottie 动画可以为直播送礼增添生动的视觉效果和互动体验，使观众感到更投入，同时提高整个直播的吸引力和娱乐性
 
 
 */

import Foundation
import Lottie //渲染高质量动画的库
import UIKit

// 定义 LottieHUD 的遮罩类型
public enum LottieHUDMaskType {
    case solid // 实心遮罩
}

// LottieHUD 类，用于显示 Lottie 动画 HUD
public final class LottieHUD {
    
    // 配置结构体，用于设置 HUD 的配置
    public struct LottieHUDConfig {
        static var shadow: CGFloat = 0.7 // 遮罩透明度
        static var animationDuration: TimeInterval = 0.3 // 动画持续时间
    }
    
    // 遮罩视图
    private var maskView: UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.isUserInteractionEnabled = false // 遮罩不响应用户交互
        bg.alpha = 0.0 // 初始透明度
        return bg
    }()
    
    // Lottie 动画视图
    private var lottie: LottieAnimationView!
    
    // 内容模式
    public var contentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            self.lottie.contentMode = contentMode // 更新 Lottie 动画的内容模式
        }
    }
    
    // 遮罩类型
    public var maskType: LottieHUDMaskType = .solid

    // HUD 尺寸
    public var size: CGSize = CGSize(width: 200, height: 200)
    
    // 初始化 LottieHUD
    init(_ name: String, loop: Bool = true) {
        self.lottie = LottieAnimationView(name: name) // 创建 Lottie 动画视图
        self.lottie.loopMode = loop ? .loop : .playOnce // 设置动画循环模式
    }
    
    // 使用 LottieAnimationView 初始化
    init(lottie: LottieAnimationView) {
        self.lottie = lottie
    }
    
    // 显示 HUD
    public func showHUD(with delay: TimeInterval = 0.0, loop: Bool = true) {
        lottie.loopMode = loop ? .loop : .playOnce // 设置动画循环模式
        createHUD(delay: delay) // 创建并显示 HUD
    }
    
    // 停止 HUD
    public func stopHUD() {
        clearHUD() // 清除 HUD
    }
    
    // 创建 HUD
    private func createHUD(delay: TimeInterval = 0.0) {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            keyWindow.isUserInteractionEnabled = false // 禁用用户交互
            
            // 配置遮罩
            self.configureMask()
            self.configureConstraints() // 配置约束
            
            // 动画显示遮罩
            UIView.animate(withDuration: LottieHUDConfig.animationDuration, delay: delay, options: .curveEaseIn, animations: {
                self.maskView.alpha = 1.0 // 设置遮罩透明度为1
            }, completion: nil)
            
            // 播放 Lottie 动画
            self.lottie.play { _ in
                self.clearHUD() // 动画完成后清除 HUD
            }
        }
    }
    
    // 配置遮罩
    private func configureMask() {
        if maskType == .solid {
            maskView.backgroundColor = UIColor.black.withAlphaComponent(LottieHUDConfig.shadow) // 设置遮罩背景颜色
        }
    }
    
    // 配置约束
    private func configureConstraints() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        keyWindow.addSubview(self.maskView) // 将遮罩添加到 keyWindow
        
        // 设置遮罩的约束
        NSLayoutConstraint.activate([
            maskView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
            maskView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
            maskView.topAnchor.constraint(equalTo: keyWindow.topAnchor),
            maskView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
        ])
        
        maskView.addSubview(lottie) // 将 Lottie 动画视图添加到遮罩中
        
        // 设置 Lottie 动画视图的约束
        lottie.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lottie.centerXAnchor.constraint(equalTo: maskView.centerXAnchor),
            lottie.centerYAnchor.constraint(equalTo: maskView.centerYAnchor),
            lottie.heightAnchor.constraint(equalToConstant: size.height),
            lottie.widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
    
    // 清除 HUD
    private func clearHUD() {
        DispatchQueue.main.async {
            // 动画隐藏遮罩
            UIView.animate(withDuration: LottieHUDConfig.animationDuration, delay: 0, options: .curveEaseIn, animations: {
                self.maskView.alpha = 0.0 // 设置遮罩透明度为0
            }) { finished in
                guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                keyWindow.isUserInteractionEnabled = true // 重新启用用户交互
                self.maskView.removeFromSuperview() // 移除遮罩
                self.lottie.stop() // 停止 Lottie 动画
            }
        }
    }
}

// 扩展 UIApplication，用于获取当前的顶层视图控制器
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        // 如果是导航控制器，递归获取顶层视图控制器
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        // 如果是标签控制器，获取选中的视图控制器
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        // 如果存在被展示的视图控制器，递归获取
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller // 返回当前控制器
    }
}
