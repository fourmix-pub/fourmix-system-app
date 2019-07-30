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
