// WCDBViewController.swift
import UIKit
import WCDBSwift

class WCDBViewController: UIViewController {
    let dbManager = DBmanager.share // 获取数据库管理器实例
    let buttonTitles = ["增", "删", "改", "查"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonWidth: CGFloat = 100
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
        print("执行增加操作")

        let model = UserModel()
        model.id = 1
        model.name = "张三8"
        model.height = 125.6

        dbManager.inser(objects: [model], intoTable: .userTable)
        print("添加的数据: \(model)")
    }

    func deleteAction() {
        let condition = Column(named: "id") == 1 // 使用 Column 直接引用列

        // 查询数据以确认即将删除的数据
        if let usersToDelete: [UserModel] = dbManager.qurey(fromTable: .userTable, where: condition) {
            if usersToDelete.isEmpty {
                print("没有找到符合条件的数据")
            } else {
                // 打印即将删除的数据
                for user in usersToDelete {
                    print("即将删除的数据: 用户ID: \(user.id), 姓名: \(user.name)")
                }

                // 执行删除操作
                dbManager.deleteFromDb(fromTable: .userTable, where: condition)

                // 删除后再次查询以确认删除成功
                if let usersAfterDelete: [UserModel] = dbManager.qurey(fromTable: .userTable, where: condition), usersAfterDelete.isEmpty {
                    print("删除成功，数据已不存在。")
                } else {
                    print("删除失败，数据仍然存在。")
                }
            }
        }
    }

    // 更新操作
    func updateAction() {
        print("执行更新操作")

        let updateCondition = UserModel.Properties.id == 1

        // Check if the user exists
        if let existingUsers: [UserModel] = dbManager.qurey(fromTable: .userTable, where: updateCondition) {
            if existingUsers.isEmpty {
                print("没有找到符合条件的记录，无法更新")
                return
            } else {
                print("找到要更新的用户: \(existingUsers)")
            }
        }

        // Create the user model to update
        let userToUpdate = UserModel()
        userToUpdate.name = "NewName"
        userToUpdate.height = 180.0

        // Define properties to update
        let propertiesToUpdate = [UserModel.Properties.name, UserModel.Properties.height]

        // Perform the update
        dbManager.update(fromTable: .userTable, on: propertiesToUpdate, itemModel: userToUpdate, where: updateCondition)

        // Query to confirm update
        if let updatedUsers: [UserModel] = dbManager.qurey(fromTable: .userTable, where: updateCondition) {
            if updatedUsers.isEmpty {
                print("更新后未找到任何符合条件的记录")
            } else {
                for user in updatedUsers {
                    print("更新后的用户ID: \(user.id), 姓名: \(user.name), 身高: \(user.height)")
                }
            }
        }
    }

    // 查询操作
    func queryAction() {
        print("执行查询操作")
        // 在此处添加查操作的逻辑
        if let users: [UserModel] = dbManager.qurey(fromTable: .userTable) {
            for user in users {
                print("用户ID: \(user.id), 姓名: \(user.name), 身高: \(user.height)")
            }
        }
    }
}

/***
 执行更新操作
 "[UserModel(id: 1, name: 张三8, height: 125.6)]"
 找到要更新的用户: [UserModel(id: 1, name: 张三8, height: 125.6)]
 "[UserModel(id: 1, name: NewName, height: 180.0)]"
 更新后的用户ID: 1, 姓名: NewName, 身高: 180.0
 执行查询操作
 "[UserModel(id: 1, name: NewName, height: 180.0)]"
 用户ID: 1, 姓名: NewName, 身高: 180.0

 */
