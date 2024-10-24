//
//  SyntacticSugarViewController.swift
//  SwiftApp
//
//  Created by mac on 24.10.24.
//

import Then
import UIKit
class SyntacticSugarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        传统
        let label_0 = UILabel(frame: CGRect(x: 10, y: 60, width: 180, height: 40))
        label_0.text = "Helloween"
        label_0.textColor = .red
        label_0.font = UIFont.systemFont(ofSize: 20)
        label_0.textAlignment = .center
        label_0.numberOfLines = 0
        view.addSubview(label_0)

//        Then语法糖
        let label_1 = UILabel(frame: CGRect(x: 10, y: 130, width: 180, height: 40)).then {
            $0.text = "Syntactic sugar"
            $0.textColor = .red
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            
        }
        view.addSubview(label_1)
        
//        假如不想用Then，可以自定义一个扩展来实现类似的效果
        let label_2 = UILabel(frame: CGRect(x: 10, y: 150, width: 280, height: 40)).configure {
            $0.text = "Syntactic sugar 配置"
            $0.textColor = .red
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            
        }
        view.addSubview(label_2)
        
        
//        列表-传统
  /*      let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
   列表-then
        let tableView = UITableView(frame: .zero, style: .plain).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
*/
        
//        按钮传统
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: .normal)
        button.backgroundColor = .blue
        button.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        
//        语法糖Then按钮
        let button1 = UIButton(type: .system).then {
            $0.setTitle("Click Me", for: .normal)
            $0.backgroundColor = .blue
            $0.frame = CGRect(x: 50, y: 240, width: 200, height: 50)
            $0.layer.cornerRadius = 10
//            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        view.addSubview(button1)
        

    }
    
}
extension UILabel {
    func configure(_ block: (UILabel) -> Void) -> UILabel {
        block(self)
        return self
    }
}
