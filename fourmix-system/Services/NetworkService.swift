//
//  NetworkService.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

enum NetworkService {
    case projectCollection
}

extension NetworkService: TargetType {
    var baseURL: URL { return URL(string: "http://fourmix-system.test/api/v1")! }
    
    var path: String {
        switch self {
        case .projectCollection:
            return "/projects"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .projectCollection:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .projectCollection:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Authorization": Token.find()?.get() ?? ""
        ]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}




