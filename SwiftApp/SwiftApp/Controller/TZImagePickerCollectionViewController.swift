//
//  TZImagePickerCollectionViewController.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import UIKit

import UIKit
import TZImagePickerController

class TZImagePickerCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate {

    var collectionView: UICollectionView!
    var selectedImages: [UIImage] = []
       
       // 图片大小和间距
       let imageSize: CGFloat = 100
       let spacing: CGFloat = 10
       let itemsPerRow = 3 // 每行显示图片的数量
       let maxImages = 9 // 允许最多选择的图片数量
       override func viewDidLoad() {
           super.viewDidLoad()
           setupCollectionView()
       }

       // 配置集合视图
       func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.itemSize = CGSize(width: imageSize, height: imageSize)
           layout.minimumInteritemSpacing = spacing
           layout.minimumLineSpacing = spacing
           
           collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.backgroundColor = .white
           collectionView.delegate = self
           collectionView.dataSource = self
           
           collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
           collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "addButtonCell")

           view.addSubview(collectionView)
           
           // 设置约束
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               collectionView.heightAnchor.constraint(equalToConstant: calculateCollectionViewHeight()) // 动态计算高度
           ])
       }

       // 根据选择图片数量计算集合视图高度
       func calculateCollectionViewHeight() -> CGFloat {
           let totalItems = selectedImages.count + 1 // 包括添加按钮
           let rows = CGFloat((totalItems + itemsPerRow - 1) / itemsPerRow) // 计算行数
           let totalHeight = rows * imageSize + (rows - 1) * spacing // 高度 = 行数 * 图片大小 + 行间距
           return totalHeight
       }

       // UICollectionView 数据源方法
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           //MARK: 包括一个用于添加按钮的单元格
//           return selectedImages.count + 1
           //MARK: 如果图片数量达到最大值，隐藏添加按钮 三目运算符: 选择图片图片数量<最大图片数量 则显示添加按钮，反之则不显示添加按钮
            return selectedImages.count < maxImages ? selectedImages.count + 1 : selectedImages.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if indexPath.item < selectedImages.count {
               // 显示图片的单元格
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
               let imageView = UIImageView(image: selectedImages[indexPath.item])
               imageView.contentMode = .scaleAspectFill
               imageView.clipsToBounds = true
               imageView.layer.cornerRadius = 10
               imageView.frame = cell.contentView.frame
               cell.contentView.addSubview(imageView)
               return cell
           } else {
               // 显示添加按钮的单元格
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addButtonCell", for: indexPath)
               let addButton = UIButton(type: .system)
               addButton.setTitle("+", for: .normal)
               addButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
               addButton.backgroundColor = .blue
               addButton.layer.cornerRadius = 10
               addButton.addTarget(self, action: #selector(onAddButtonClick), for: .touchUpInside)
               addButton.frame = cell.contentView.frame
               cell.contentView.addSubview(addButton)
               return cell
           }
       }

       // 点击添加按钮，打开图片选择器
       @objc func onAddButtonClick() {
           let imagePicker = TZImagePickerController(maxImagesCount: maxImages, delegate: self)
           imagePicker?.allowPickingVideo = false
           imagePicker?.didFinishPickingPhotosHandle = { [weak self] (photos, assets, isSelectOriginalPhoto) in
               guard let self = self, let photos = photos else { return }
               self.selectedImages.append(contentsOf: photos)
               self.updateCollectionViewHeight()  // 更新集合视图高度
               self.collectionView.reloadData()
           }
           self.present(imagePicker!, animated: true, completion: nil)
       }

       // 动态更新集合视图高度
       func updateCollectionViewHeight() {
           let newHeight = calculateCollectionViewHeight()
           collectionView.constraints.forEach { constraint in
               if constraint.firstAttribute == .height {
                   constraint.constant = newHeight
               }
           }
       }
   }
