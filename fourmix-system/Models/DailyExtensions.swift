//
//  DailyExtensions.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import Moya

extension DailyCollection {
    static func load(callback: @escaping (DailyCollection?) -> Void) {
        NetworkProvider.main.data(request: .userDailies) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let dailyCollection = try! coder.decode(DailyCollection.self, from: data)
                callback(dailyCollection)
            } else {
                callback(nil)
            }
        }
    }
}

extension DailyCreator {
    func create(callback: @escaping (DailyCollection?) -> Void) {
        NetworkProvider.main.data(request: .dailyCreate(dailyCreator: self)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let dailyCollection = try! coder.decode(DailyCollection.self, from: data)
                callback(dailyCollection)
            } else {
                callback(nil)
            }
        }
    }
    
    func update(callback: @escaping (DailyCollection?) -> Void) {
        NetworkProvider.main.data(request: .dailyUpdate(dailyCreator: self)) { (data) in
            if let data = data {
                let coder = JSONDecoder()
                let dailyCollection = try! coder.decode(DailyCollection.self, from: data)
                callback(dailyCollection)
            } else {
                callback(nil)
            }
        }
    }
    
    func delete(callback: @escaping (Bool?) -> Void) {
        NetworkProvider.main.data(request: .dailyDelete(dailyCreator: self)) { (data) in
            if let data = data {
                
                callback(true)
            } else {
                callback(false)
            }
        }
    }
}
