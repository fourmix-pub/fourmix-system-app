//
//  UserExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension UserCollection {
    static func load(callback: @escaping (UserCollection?) -> Void) {
        NetworkProvider.main.data(request: .userCollection) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let userCollection = try! coder.decode(UserCollection.self, from: data)
                callback(userCollection)
            } else {
                callback(nil)
            }
        }
    }
}

extension UserData {
    static func getProfile(callback: @escaping (UserData?) -> Void) {
        NetworkProvider.main.data(request: .profile) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let userData = try! coder.decode(UserData.self, from: data)
                callback(userData)
            } else {
                callback(nil)
            }
        }
    }
}

extension UserCreator {
    func updateProfile(callback: @escaping (UserData?) -> Void) {
        NetworkProvider.main.data(request: .userUpdate(userCreator: self)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let userData = try! coder.decode(UserData.self, from: data)
                callback(userData)
            } else {
                callback(nil)
            }
        }
    }
}
