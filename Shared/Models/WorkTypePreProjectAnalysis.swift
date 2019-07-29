//
//  WorkTypePreProjectAnalysis.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct WorkTypePreProjectAnalysis: Codable {
    var id: Int
    var attributes: Attributes
    var relationships: Relationships
    var links: Links
    
    struct Attributes: Codable {
        var workType: String
        var workTime: Double
        var workCost: Int
        
        enum CodingKeys: String, CodingKey {
            case workType = "work_type"
            case workTime = "work_time"
            case workCost = "work_cost"
        }
    }
    
    struct Relationships: Codable {
        var project: Project
    }
    
    struct Links: Codable {
        var `self`: String?
    }
}