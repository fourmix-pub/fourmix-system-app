//
//  NetworkService.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

enum NetworkService {
    case profile
    case userCollection
    case userUpdate(userCreator: UserCreator)
    case userDailies
    case dailyCollection(query: [String: Any])
    case dailyCreate(dailyCreator: DailyCreator)
    case dailyUpdate(dailyCreator: DailyCreator)
    case dailyDelete(dailyCreator: DailyCreator)
    case projectCollection
    case workTypeCollection
    case jobTypeCollection
    case customerCollection
    case departmentCollection
    case workTypePreProjectAnalysis(query: [String: Any])
    case userPreProjectAnalysis(query: [String: Any])
    case workTypePreUserAnalysis(query: [String: Any])
    case projectPreUserAnalysis(query: [String: Any])
}

extension NetworkService: TargetType {
    
    var baseURL: URL { return URL(string: "http://fourmix-system.test/api/v1")! }
    
    var path: String {
        switch self {
        case .profile, .userUpdate:
            return "/users/profile"
        case .userCollection:
            return "/users"
        case .userDailies:
            return "/users/dailies"
        case .dailyCollection, .dailyCreate:
            return "/dailies"
        case .dailyUpdate(let dailyCreator), .dailyDelete(let dailyCreator):
            return "/dailies/\(dailyCreator.id!)"
        case .projectCollection:
            return "/projects"
        case .workTypeCollection:
            return "/workTypes"
        case .jobTypeCollection:
            return "/jobTypes"
        case .customerCollection:
            return "/customers"
        case .departmentCollection:
            return "/departments"
        case .workTypePreProjectAnalysis:
            return "/analytics/workTypePreProject"
        case .userPreProjectAnalysis:
            return "/analytics/userPreProject"
        case .workTypePreUserAnalysis:
            return "/analytics/workTypePreUser"
        case .projectPreUserAnalysis:
            return "/analytics/projectPreUser"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .profile, .userCollection, .userDailies, .dailyCollection, .projectCollection, .workTypeCollection, .jobTypeCollection, .customerCollection, .departmentCollection, .workTypePreProjectAnalysis, .userPreProjectAnalysis, .workTypePreUserAnalysis, .projectPreUserAnalysis:
            return .get
        case .dailyCreate:
            return .post
        case .userUpdate, .dailyUpdate:
            return .patch
        case .dailyDelete:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .profile, .userCollection, .userDailies, .projectCollection, .dailyDelete, .workTypeCollection, .jobTypeCollection, .customerCollection, .departmentCollection:
            return .requestPlain
        case let .dailyCollection(query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        case let .userUpdate(userCreator):
            return .requestParameters(parameters: [
                "name": userCreator.name as Any,
                "email": userCreator.email as Any,
                "start": userCreator.start as Any,
                "end": userCreator.end as Any,
                "password": userCreator.password as Any
                ], encoding: JSONEncoding.default)
        case let .dailyCreate(dailyCreator):
            return .requestParameters(parameters: [
                "work_type_id": dailyCreator.workTypeId as Any,
                "job_type_id": dailyCreator.jobTypeId as Any,
                "project_id": dailyCreator.projectId as Any,
                "date": dailyCreator.date as Any,
                "start": dailyCreator.start as Any,
                "end": dailyCreator.end as Any,
                "rest": dailyCreator.rest as Any,
                "note": dailyCreator.note as Any
                ], encoding: JSONEncoding.default)
        case let .dailyUpdate(dailyCreator):
            return .requestParameters(parameters: [
                "work_type_id": dailyCreator.workTypeId as Any,
                "job_type_id": dailyCreator.jobTypeId as Any,
                "project_id": dailyCreator.projectId as Any,
                "date": dailyCreator.date as Any,
                "start": dailyCreator.start as Any,
                "end": dailyCreator.end as Any,
                "rest": dailyCreator.rest as Any,
                "note": dailyCreator.note as Any
                ], encoding: JSONEncoding.default)
        case let .workTypePreProjectAnalysis(query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        case let .userPreProjectAnalysis(query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        case let .workTypePreUserAnalysis(query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        case let .projectPreUserAnalysis(query):
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Authorization": (Token.find()?.get() ?? "")
        ]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
