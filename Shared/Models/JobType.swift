//
//  JobType.swift
//  fourmix-system
//
//  Created by 高木駿 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct JobType: Codable {
    var id: Int
    var attributes: Attributes
    var links: Links
    
    struct Attributes: Codable {
        var name: String
        var unitBettingRate: Double
        var createdAt: String
        var updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case unitBettingRate = "unit_betting_rate"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    struct Links: Codable {
        var `self`: String?
    }
}

struct JobTypeCollection: Codable {
    var data: [JobType]
}
