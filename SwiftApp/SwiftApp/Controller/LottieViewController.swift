//
//  LottieViewController.swift
//  SwiftApp
//
//  Created by mac on 24.10.24.
//

// import Lottie
// import
import FLAnimatedImage // 加载和播放 GIF----->展示动态图片内容的场景
import UIKit

class LottieViewController: UIViewController {
    var hud = LottieHUD("veil")
    var timer = Timer()
    var animationView: LottieAnimationView?
    let buttonTitles = ["Lottie播放", "Lottie循环播放", "不重复播放", "人为控制停止播放"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let gifImageView = FLAnimatedImageView()
        gifImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        gifImageView.center = view.center

        // 加载 GIF 数据
        if let gifPath = Bundle.main.path(forResource: "牛顿摇篮动画书", ofType: "gif"),
           let gifData = NSData(contentsOfFile: gifPath) {
            let gifAnimatedImage = FLAnimatedImage(animatedGIFData: gifData as Data)
            gifImageView.animatedImage = gifAnimatedImage
        }

        // 将 FLAnimatedImageView 添加到视图中
        view.addSubview(gifImageView)

        let buttonWidth: CGFloat = 300
        let buttonHeight: CGFloat = 50

        // 定义按钮之间的间距
        let buttonSpacing: CGFloat = 20

        // 循环创建4个按钮
        for i in 0 ..< 4 {
            // 创建按钮
            let button = UIButton(type: .system)

            // 设置按钮的标题
            button.setTitle(buttonTitles[i], for: .normal)
            // 设置按钮的背景颜色
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)

            // 设置按钮的框架 (x, y, width, height)
            let xPos = (view.frame.width - buttonWidth) / 2 // 居中
            let yPos = CGFloat(i) * (buttonHeight + buttonSpacing) + 100 // 垂直间隔排列
            button.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonHeight)

            // 设置按钮的 tag
            button.tag = i // 为按钮设置唯一的 tag

            // 给按钮添加点击事件
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            // 添加按钮到视图
            view.addSubview(button)
        }
    }

    // 按钮点击事件处理方法
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            addAction()
        case 1:
            deleteAction()
        case 2:
            updateAction()
        case 3:
            queryAction()
        default:
            break
        }
    }

    func addAction() {
        hud.showHUD()
//        定时器8秒后消失
        Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(dismissHUD), userInfo: nil, repeats: false)
    }

    func deleteAction() {
        //        HUD 将在调用该方法后立即开始显示遮罩，但实际的动画显示效果会在 2 秒后开始，会一直播放，2秒后不断加载遮罩 循环播放
//        LottieHUD("veil").showHUD(with: 2.0) // 消失逻辑未写
//        建议下面方法
        let hud = LottieHUD("veil") // 确保 hud 是在合适的地方初始化
        hud.showHUD(with: 2.0) // 使用合适的显示逻辑

    }

    func updateAction() {
//        不会循环播放，1秒后自动消失
        hud.showHUD(loop: false)
    }

    func queryAction() {
    }

    @objc func dismissHUD() {
        hud.stopHUD()
    }
}
