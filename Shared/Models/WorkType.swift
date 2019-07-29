//
//  WorkType.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct WorkType: Codable {
    var id: Int
    var attributes: Attributes
    var relationships: Relationships
    var links: Links
    
    struct Attributes: Codable {
        var name: String
        var createdAt: String
        var updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    struct Relationships: Codable {}
    
    struct Links: Codable {
        var `self`: String?
    }
}

struct WorkTypeCollection {
    var data: [WorkType]
}
