//
//  Systems.swift
//  fourmix-system
//
//  Created by 高木駿 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct Errors: Codable {
    var message: String
    var errors: [String: [String]]
}
