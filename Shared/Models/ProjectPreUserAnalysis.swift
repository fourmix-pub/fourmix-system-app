//
//  ProjectPreUserAnalysis.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct ProjectPreUserAnalysis: Codable {
    var id: Int
    var attributes: Attributes
    var relationships: Relationships
    var links: Links
    
    struct Attributes: Codable {
        var customerName: String
        var projectName: String
        var workTime: Double
        var workCost: Int
        
        enum CodingKeys:String, CodingKey {
            case customerName = "customer_name"
            case projectName = "project_name"
            case workTime = "work_time"
            case workCost = "work_cost"
        }
    }
    
    struct Relationships: Codable {
        var user: User
    }
    
    struct Links: Codable {
        var `self`: String?
    }
}
