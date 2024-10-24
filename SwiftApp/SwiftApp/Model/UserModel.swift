//
//  User.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

import UIKit
import WCDBSwift
import WCDBSwift

import WCDBSwift

import Foundation
import WCDBSwift

final class UserModel: TableCodable,CustomStringConvertible {
 
    var id: Int = 0
    var name: String = ""
    var height: Double = 0.0
      
    enum CodingKeys: String, CodingTableKey {
        typealias Root = UserModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case name
        case height
    }
    var description: String {
            return "UserModel(id: \(id), name: \(name), height: \(height))"
        }
}
