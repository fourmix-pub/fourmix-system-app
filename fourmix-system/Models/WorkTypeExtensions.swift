//
//  WorkTypeExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension WorkTypeCollection {
    static func load(callback: @escaping (WorkTypeCollection?) -> Void) {
        NetworkProvider.main.data(request: .workTypeCollection) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let workTypeCollection = try! coder.decode(WorkTypeCollection.self, from: data)
                callback(workTypeCollection)
            } else {
                callback(nil)
            }
        }
    }
}
