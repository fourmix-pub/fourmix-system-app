//
//  AuthService.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/25.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

let clientId = "2"
let clientSecret = "75As5N94p6hc7fBsaSDQDpOD8l4BfvVWR0aZLZ8P"
let oauthUrl = "http://fourmix-system.test"

enum AuthService {
    case login(email: String, password: String)
}

extension AuthService: TargetType {
    var baseURL: URL { return URL(string: oauthUrl)! }
    
    var path: String {
        return "/oauth/token"
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: [
                "grant_type": "password",
                "client_id": clientId,
                "client_secret": clientSecret,
                "username": email,
                "password": password,
                "scope": "*",
                ], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
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


