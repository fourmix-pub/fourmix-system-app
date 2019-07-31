//
//  JobTypeExtensions.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension JobTypeCollection {
    static func load(callback: @escaping (JobTypeCollection?) -> Void) {
        NetworkProvider.main.data(request: .jobTypeCollection) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let jobTypeCollection = try! coder.decode(JobTypeCollection.self, from: data)
                callback(jobTypeCollection)
            } else {
                callback(nil)
            }
        }
    }
}
