//
//  TouTiaoNetworkRequest.swift
//  SwiftApp
//
//  Created by mac on 23.10.24.
//

// import Foundation
import Moya

enum TouTiaoNetworkRequest {
    case fetchNews
}

extension TouTiaoNetworkRequest: TargetType {
    var baseURL: URL {
//        return URL(string: "https://v.juhe.cn/toutiao")!
        return URL(string: "http://172.20.10.2:8080")!
    }

    var path: String {
        switch self {
        case .fetchNews:
//            return "/index"
            return "/news"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? {
        //            不需要参数 返回nil
        return nil
//        switch self {
//        case .fetchNews:
//            return ["type": "top", "key": "d1287290b45a69656de361382bc56dcd"]

//        }
    }

    var headers: [String: String]? {
        return nil
    }

    var sampleData: Data {
        return Data() // 可以返回示例数据用于调试
    }

    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
}
