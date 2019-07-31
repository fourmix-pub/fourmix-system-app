//
//  ProjectPreUserAnalysisExtensions.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension ProjectPreUserAnalysisCollection {
    static func load(query: [String: Any], callback: @escaping (ProjectPreUserAnalysisCollection?) -> Void) {
        NetworkProvider.main.data(request: .projectPreUserAnalysisCollection(query: query)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let projectPreUserAnalysisCollection = try! coder.decode(ProjectPreUserAnalysisCollection.self, from: data)
                callback(projectPreUserAnalysisCollection)
            } else {
                callback(nil)
            }
        }
    }
}
