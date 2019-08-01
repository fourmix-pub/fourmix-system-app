//
//  WorkTypePreUserAnalysisExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension WorkTypePreUserAnalysisCollection {
    static func load(query: [String: Any], callback: @escaping (WorkTypePreUserAnalysisCollection?) -> Void) {
        NetworkProvider.main.data(request: .workTypePreUserAnalysisCollection(query: query)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let workTypePreUserAnalysisCollection = try! coder.decode(WorkTypePreUserAnalysisCollection.self, from: data)
                callback(workTypePreUserAnalysisCollection)
            } else {
                callback(nil)
            }
        }
    }
}
