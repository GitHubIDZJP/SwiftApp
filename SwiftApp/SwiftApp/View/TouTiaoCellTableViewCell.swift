//
//  TouTiaoCellTableViewCell.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import UIKit
import SnapKit
class TouTiaoCellTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let thumbnailImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    private func setupViews() {
        
          titleLabel.numberOfLines = 0 // 允许多行
          authorLabel.numberOfLines = 0
        
           // 配置 titleLabel
           titleLabel.numberOfLines = 0
//         titleLabel.text =  "sdsd"
//         titleLabel.backgroundColor = .purple
           contentView.addSubview(titleLabel)
           
           // 配置 authorLabel
           authorLabel.font = UIFont.systemFont(ofSize: 12)
//         authorLabel.backgroundColor = .yellow
           contentView.addSubview(authorLabel)
           
           // 配置 thumbnailImageView
//         thumbnailImageView.backgroundColor = .blue
           thumbnailImageView.contentMode = .scaleAspectFill
           thumbnailImageView.clipsToBounds = true
           contentView.addSubview(thumbnailImageView)

           // 设置 Auto Layout 约束
           setupConstraints()
       }
//    private func setupConstraints() {
//        thumbnailImageView.snp.makeConstraints { (make) in
//            make.leading.equalTo(contentView).offset(10)
//            make.centerY.equalTo(contentView)
//            make.width.height.equalTo(100)
//        }
//
//        titleLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
//            make.trailing.equalTo(contentView).offset(-10)
//            make.top.equalTo(contentView).offset(10)
//        }
//
//        authorLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
//            make.trailing.equalTo(contentView).offset(-10)
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            make.bottom.equalTo(contentView).offset(-10)
//        }
//    }
    private func setupConstraints() {
        thumbnailImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(60)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView).offset(10)
        }

        authorLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }


}
