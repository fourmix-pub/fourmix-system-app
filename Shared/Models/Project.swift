//
//  Project.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct Project: Codable {
    var id: Int
    var attributes: Attributes
    var relationships: Relationships
    var links: Links
    
    struct Attributes: Codable {
        var name: String
        var customerId: Int
        var cost: Int
        var budget: Int
        var userId: Int
        var start: String
        var end: String?
        var endExpect: String
        var note: String?
        var canDisplay: Int?
        var createdAt: String
        var updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case customerId = "customer_id"
            case cost
            case budget
            case userId = "user_id"
            case start
            case end
            case endExpect = "end_expect"
            case note
            case canDisplay = "can_display"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    struct Relationships: Codable {
        var customer: Customer
        var user: User
    }
    
    struct Links: Codable {
        var `self`: String?
    }
}

struct ProjectCollection: Codable {
    var data: [Project]
}
