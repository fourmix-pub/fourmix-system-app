//
//  NotificationService.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/25.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import Foundation

struct LocalNotificationService {
    static let unauthorized = Notification.Name("unauthorized")
    static let networkError = Notification.Name("networkError")
    static let inputError = Notification.Name("inputError")
    static let userHasSelected = Notification.Name("userHasSelected")
    static let profileHasUpdated = Notification.Name("profileHasUpdated")
    static let passwordHasReset = Notification.Name("passwordHasReset")

}
