//
//  UserPreProjectAnalysisExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension UserPreProjectAnalysisCollection {
    static func load(query: [String: Any], callback: @escaping (UserPreProjectAnalysisCollection?) -> Void) {
        NetworkProvider.main.data(request: .userPreProjectAnalysisCollection(query: query)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let userPreProjectAnalysisCollection = try! coder.decode(UserPreProjectAnalysisCollection.self, from: data)
                callback(userPreProjectAnalysisCollection)
            } else {
                callback(nil)
            }
        }
    }
}
