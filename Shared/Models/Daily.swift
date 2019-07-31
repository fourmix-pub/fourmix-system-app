//
//  Daily.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct Daily: Codable {
    var id: Int
    var attributes: Attributes
    var relationships: Relationships
    var links: Links
    
    struct Attributes: Codable {
        var userId: Int
        var workTypeId: Int
        var jobTypeId: Int
        var projectId: Int
        var date: String
        var start: String
        var end: String
        var rest: Int?
        var time: Double
        var cost: Int
        var note: String?
        var createdAt: String
        var updatedAt: String
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case workTypeId = "work_type_id"
            case jobTypeId =  "job_type_id"
            case projectId = "project_id"
            case date
            case start
            case end
            case rest
            case time
            case cost
            case note
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    struct Relationships: Codable {
        var user: User
        var workType: WorkType
        var jobType: JobType
        var project: Project
        
        enum CodingKeys: String, CodingKey {
            case user
            case workType = "work_type"
            case jobType =  "job_type"
            case project
        }
    }
    
    struct Links: Codable {
        var `self`: String?
    }
}

struct DailyCollection: Codable {
    var data: [Daily]
}

struct DailyData: Codable {
    var data: Daily
}

struct DailyCreator {
    var id: Int?
    var workTypeId: Int?
    var jobTypeId: Int?
    var projectId: Int?
    var date: String?
    var start: String?
    var end: String?
    var rest: Int?
    var note: String?
}
