//
//  TouTiaoModel.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import UIKit
import Foundation

//用HandyJSON做模型
//import HandyJSON
//class TouTiaoModel: HandyJSON {
//    var title: String?
//    var author_name: String?
//    var thumbnail_pic_s: String?
//
//    required init() {}
//   
//}


//用ObjectMapper做模型
import ObjectMapper

class TouTiaoModel: Mappable {
    var title: String?
    var author_name: String?
    var thumbnail_pic_s: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        title <- map["title"]
        author_name <- map["author_name"]
        thumbnail_pic_s <- map["thumbnail_pic_s"]
    }
}
