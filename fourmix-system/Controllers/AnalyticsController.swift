//
//  AnalyticsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import KRProgressHUD

class AnalyticsController: UITableViewController {
    
    var users: [User] = []
    var projects: [Project] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        KRProgressHUD.show()
        
        DispatchQueue.main.async {
            ProjectCollection.load { (projectCollection) in
                if let projectCollection = projectCollection {
                    self.projects = projectCollection.data
                    if self.projects.count > 0 && self.users.count > 0 {
                        KRProgressHUD.dismiss()
                    }
                }
            }
            
            UserCollection.load { (userCollection) in
                if let userCollection = userCollection {
                    self.users = userCollection.data
                    if self.projects.count > 0 && self.users.count > 0 {
                        KRProgressHUD.dismiss()
                    }
                }
            }
        }
    }

    @IBAction func refreshButtonHasTapped(_ sender: Any) {
        self.loadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "UserPreProjectAnalysisSegue", "WorkTypePreProjectAnalysisSegue":
            let destination = segue.destination as! PreProjectAnalyticsController
            destination.segueIdentifier = segue.identifier
            destination.projects = self.projects
        case "ProjectPreUserAnalysisSegue", "WorkTypePreUserAnalysisSegue":
            let destination = segue.destination as! PreUserAnalyticsController
            destination.segueIdentifier = segue.identifier
            destination.users = self.users
        default:
            break
        }
    }
}
