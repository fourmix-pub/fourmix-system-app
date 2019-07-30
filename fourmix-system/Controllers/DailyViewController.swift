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

    @IBOutlet weak var userNameLabel: UILabel!
    
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
