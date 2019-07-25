//
//  Token.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/25.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

struct Token: Codable {
    var token_type: String
    var access_token: String
    
    enum Key: String {
        case oauthTokenType
        case oauthAccessToken
    }
    
    static func loginRequest(email: String, password: String, callback: @escaping (Token?) -> Void) {
        let provider = MoyaProvider<AuthService>()
        provider.request(.login(email: email, password: password)) { (result) in
            switch result {
            case let .success(response):
                
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let data = response.data
                    let coder = JSONDecoder()
                    let token = try coder.decode(Token.self, from: data)
                    callback(token)
                } catch {
                    if response.statusCode == 401 {
                        NotificationCenter.default.post(name: LocalNotificationService.unauthorized, object: nil, userInfo: [
                            "code": 401,
                            "message": "メールアドレスまたはパスワードが間違っています。"
                            ])
                        callback(nil)
                    } else {
                        print(error)
                        print(response.statusCode)
                        NotificationCenter.default.post(name: LocalNotificationService.networkError, object: nil, userInfo: [
                            "code": response.statusCode,
                            "message": "サーバーへ接続ができません。インターネット接続を確認してください。"
                            ])
                        callback(nil)
                    }
                }
                
                break
            case let .failure(error):
                print(error)
                NotificationCenter.default.post(name: LocalNotificationService.networkError, object: nil, userInfo: [
                    "code": 9999,
                    "message": "サーバーへ接続ができません。インターネット接続を確認してください。"
                    ])
                callback(nil)
                break
            }
        }
    }
    
    func save() {
        UserDefaults.standard.setValue(self.token_type, forOauthKey: .oauthTokenType)
        UserDefaults.standard.setValue(self.access_token, forOauthKey: .oauthAccessToken)
    }
    
    static func find() -> Token? {
        let tokenType = UserDefaults.standard.string(forOauthKey: .oauthTokenType)
        let accessToken = UserDefaults.standard.string(forOauthKey: .oauthAccessToken)
        
        if let tokenType = tokenType, let accessToken = accessToken {
            return Token(token_type: tokenType, access_token: accessToken)
        } else {
            return nil
        }
    }
    
    func get() -> String {
        return "\(token_type) \(access_token)"
    }
    
    static func logout() -> Bool {
        UserDefaults.standard.removeObject(forKey: Token.Key.oauthTokenType.rawValue)
        UserDefaults.standard.removeObject(forKey: Token.Key.oauthAccessToken.rawValue)
        
        return true
    }
}

extension UserDefaults {
    func setValue(_ value: Any?, forOauthKey key: Token.Key) {
        self.set(value, forKey: key.rawValue)
    }
    
    func string(forOauthKey key: Token.Key) -> String? {
        return self.string(forKey: key.rawValue)
    }
}

