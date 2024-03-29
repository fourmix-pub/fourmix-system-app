//
//  PreUserAnalyticsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import KRProgressHUD

class PreUserAnalyticsController: UITableViewController {
    
    var segueIdentifier: String!

    var users: [User]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observes()
        
        navigationItem.title = naviTitle(from: segueIdentifier)
    }
    
    func observes() {
        NotificationCenter.default.addObserver(forName: LocalNotificationService.inputError, object: nil, queue: nil) { (notification) in
            guard let message = notification.userInfo!["message"] else { return }
            
            let alert = UIAlertController(title: "エラーです", message: message as? String, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                alert.dismiss(animated: true)
            })
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreUserAnalysisCell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].attributes.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let query:[String: Any] = [
            "user_id": user.id
        ]
        
        if segueIdentifier == "WorkTypePreUserAnalysisSegue" {
            KRProgressHUD.show()
            WorkTypePreUserAnalysisCollection.load(query: query) { (workTypePreUserAnalysisCollection) in
                KRProgressHUD.dismiss()
                if let workTypePreUserAnalysisCollection = workTypePreUserAnalysisCollection {
                    self.performSegue(withIdentifier: self.identifier(from: self.segueIdentifier), sender: [
                        "user": user,
                        "data": workTypePreUserAnalysisCollection
                        ])
                }
            }
        }
        
        if segueIdentifier == "ProjectPreUserAnalysisSegue" {
            KRProgressHUD.show()
            ProjectPreUserAnalysisCollection.load(query: query) { (projectPreUserAnalysisCollection) in
                KRProgressHUD.dismiss()
                if let projectPreUserAnalysisCollection = projectPreUserAnalysisCollection {
                    self.performSegue(withIdentifier: self.identifier(from: self.segueIdentifier), sender: [
                        "user": user,
                        "data": projectPreUserAnalysisCollection
                        ])
                }
            }
        }
    }
    
    func identifier(from segueIdentifier: String) -> String {
        switch segueIdentifier {
        case "WorkTypePreUserAnalysisSegue":
            return "WorkTypePreUserAnalysisDetailSegue"
        case "ProjectPreUserAnalysisSegue":
            return "ProjectPreUserAnalysisDetailSegue"
        default:
            return ""
        }
    }
    
    func naviTitle(from segueIdentifier: String) -> String {
        switch segueIdentifier {
        case "WorkTypePreUserAnalysisSegue":
            return "担当者別作業分類"
        case "ProjectPreUserAnalysisSegue":
            return "担当者別プロジェクト集計表"
        default:
            return ""
        }
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkTypePreUserAnalysisDetailSegue" {
            let destination = segue.destination as! WorkTypePreUserAnalysisDetailController
            let sender = sender as! [String: Any?]
            let workTypePreUserAnalysisCollection = sender["data"] as? WorkTypePreUserAnalysisCollection
            let user = sender["user"] as? User
            destination.workTypePreUserAnalysisDetails = workTypePreUserAnalysisCollection?.data
            destination.user = user
        }
        
        if segue.identifier == "ProjectPreUserAnalysisDetailSegue" {
            let destination = segue.destination as! ProjectPreUserAnalysisDetailController
            let sender = sender as! [String: Any?]
            let projectPreUserAnalysisCollection = sender["data"] as? ProjectPreUserAnalysisCollection
            let user = sender["user"] as? User
            destination.projectPreUserAnalysisDetails = projectPreUserAnalysisCollection?.data
            destination.user = user
        }
     }
}
