//
//  UserPreProjectAnalysis.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct UserPreProjectAnalysis: Codable {
    var id: Int
    var attributes: Attributes
    var links: Links
    
    struct Attributes: Codable {
        var userName: String
        var workTime: Double
        var workCost: Int
        var workCostWithFormat: String
        
        enum CodingKeys: String, CodingKey {
            case userName = "user_name"
            case workTime = "work_time"
            case workCost = "work_cost"
            case workCostWithFormat = "work_cost_with_format"
        }
    }
    
    struct Links: Codable {
        var `self`: String?
    }
}
