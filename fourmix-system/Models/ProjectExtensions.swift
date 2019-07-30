//
//  ProjectExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension ProjectCollection {
    static func load(callback: @escaping (ProjectCollection?) -> Void) {
        NetworkProvider.main.data(request: .projectCollection) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let projectCollection = try! coder.decode(ProjectCollection.self, from: data)
                callback(projectCollection)
            } else {
                callback(nil)
            }
        }
    }
}

