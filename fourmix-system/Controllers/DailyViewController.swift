//
//  DailyViewController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class DailyViewController: UITableViewController {
    
    var user: User?
    var project: Project?

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observes()
    }
    
    func observes() {
        NotificationCenter.default.addObserver(forName: LocalNotificationService.userHasSelected, object: nil, queue: nil) { (notification) in
            guard let user = notification.userInfo!["user"] else { return }
            
            self.user = user as? User
            
            if let user = self.user {
                self.userNameLabel.text = user.attributes.name
            }
        }
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.projectHasSelected, object: nil, queue: nil) { (notification) in
            guard let project = notification.userInfo!["project"] else { return }
            
            self.project = project as? Project
            
            if let project = self.project {
                self.projectNameLabel.text = project.attributes.name
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
