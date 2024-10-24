//
//  TZImagePickerViewController.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import TZImagePickerController
import UIKit
class TZImagePickerScrollViewController: UIViewController, TZImagePickerControllerDelegate {
    let scrollView = UIScrollView()
    let addButton = UIButton()
    var selectedImages: [UIImage] = []

    // 设置图片大小和间距
    let imageSize: CGFloat = 100
    let spacing: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateImageViews()
    }

    // 配置UI
    func setupUI() {
        view.backgroundColor = .white

        // 配置 ScrollView
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.heightAnchor.constraint(equalToConstant: imageSize),
        ])

        // 配置添加按钮
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = .blue
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(onAddButtonClick), for: .touchUpInside)
        scrollView.addSubview(addButton)
    }

    // 点击添加按钮，打开图片选择器
    @objc func onAddButtonClick() {
        let imagePicker = TZImagePickerController(maxImagesCount: 9, delegate: self)
        imagePicker?.allowPickingVideo = false
        imagePicker?.didFinishPickingPhotosHandle = { [weak self] photos, _, _ in
            guard let self = self, let photos = photos else { return }
            self.selectedImages.append(contentsOf: photos)
            self.updateImageViews()
        }
        present(imagePicker!, animated: true, completion: nil)
    }

    // 更新图片视图
    func updateImageViews() {
        // 移除之前的所有图片视图
        for subview in scrollView.subviews where subview != addButton {
            subview.removeFromSuperview()
        }

        // 动态添加图片
        for (index, image) in selectedImages.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.frame = CGRect(x: CGFloat(index) * (imageSize + spacing), y: 0, width: imageSize, height: imageSize)
            scrollView.addSubview(imageView)
        }

        // 更新添加按钮的位置到最后一张图片的右侧
        let addButtonX = CGFloat(selectedImages.count) * (imageSize + spacing)
        addButton.frame = CGRect(x: addButtonX, y: 0, width: imageSize, height: imageSize)

        // 更新 ScrollView 的内容宽度
        let contentWidth = addButtonX + imageSize + spacing
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
    }
}
