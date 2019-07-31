//
//  WorkTypePreProjectAnalysisExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension WorkTypePreProjectAnalysisCollection {
    static func load(query: [String: Any], callback: @escaping (WorkTypePreProjectAnalysisCollection?) -> Void) {
        NetworkProvider.main.data(request: .workTypePreProjectAnalysisCollection(query: query)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let workTypePreProjectAnalysisCollection = try! coder.decode(WorkTypePreProjectAnalysisCollection.self, from: data)
                callback(workTypePreProjectAnalysisCollection)
            } else {
                callback(nil)
            }
        }
    }
}
