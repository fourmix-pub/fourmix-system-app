//
//  User.swift
//  fourmix-system
//
//  Created by 高木駿 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var attributes: Attributes
    var relationships: Relationships
    var links: Links
    
    struct Attributes: Codable {
        var name: String
        var email: String
        var departmentId: Int
        var cost: Int
        var start: String
        var end: String
        var isResignation: Int
        var createdAt: String
        var updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case email
            case departmentId = "department_id"
            case cost
            case start
            case end
            case isResignation = "is_resignation"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }

    }
    
    struct Relationships: Codable {
        var department: Department
    }
    
    struct Links: Codable {
        var `self`: String?
    }
    
}

struct UserCollection: Codable {
    var data: [User]
}

struct UserCreator {
    var name: String?
    var email: String?
    var password: String?
    var passwordConform: String?
}
