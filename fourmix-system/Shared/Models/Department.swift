//
//  Department.swift
//  fourmix-system
//
//  Created by 高木駿 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation
import Moya

struct Department: Codable {
    var id: Int
    var attributes: Attributes
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
    
    struct Links: Codable {
        var `self`: String?
    }
}

struct DepartmentCollection {
    var data: [Department]
}
