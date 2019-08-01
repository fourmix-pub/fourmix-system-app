//
//  Others.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/08/01.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct Links: Codable {
    var first: String?
    var last: String?
    var prev: String?
    var next: String?
}

struct Meta: Codable {
    var current_page: Int?
    var from: Int?
    var last_page: Int?
    var path: String?
    var per_page: Int?
    var to: Int?
    var total: Int?
}
