//
//  PreProjectAnalyticsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import KRProgressHUD

class PreProjectAnalyticsController: UITableViewController {

    var segueIdentifier: String!
    
    var projects: [Project]!
    
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
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreProjectAnalysisCell", for: indexPath)
        
        cell.textLabel?.text = projects[indexPath.row].attributes.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        
        let query:[String: Any] = [
            "project_id": project.id
        ]
        
        if segueIdentifier == "WorkTypePreProjectAnalysisSegue" {
            KRProgressHUD.show()
            WorkTypePreProjectAnalysisCollection.load(query: query) { (workTypePreProjectAnalysisCollection) in
                KRProgressHUD.dismiss()
                if let workTypePreProjectAnalysisCollection = workTypePreProjectAnalysisCollection {
                    self.performSegue(withIdentifier: self.identifier(from: self.segueIdentifier), sender: [
                        "project": project,
                        "data": workTypePreProjectAnalysisCollection
                        ])
                }
            }
        }
        
        if segueIdentifier == "UserPreProjectAnalysisSegue" {
            KRProgressHUD.show()
            UserPreProjectAnalysisCollection.load(query: query) { (userPreProjectAnalysisCollection) in
                KRProgressHUD.dismiss()
                if let userPreProjectAnalysisCollection = userPreProjectAnalysisCollection {
                    self.performSegue(withIdentifier: self.identifier(from: self.segueIdentifier), sender: [
                        "project": project,
                        "data": userPreProjectAnalysisCollection
                        ])
                }
            }
        }
    }
    
    func identifier(from segueIdentifier: String) -> String {
        switch segueIdentifier {
        case "WorkTypePreProjectAnalysisSegue":
            return "WorkTypePreProjectAnalysisDetailSegue"
        case "UserPreProjectAnalysisSegue":
            return "UserPreProjectAnalysisDetailSegue"
        default:
            return ""
        }
    }
    
    func naviTitle(from segueIdentifier: String) -> String {
        switch segueIdentifier {
        case "WorkTypePreProjectAnalysisSegue":
            return "プロジェクト別作業分類"
        case "UserPreProjectAnalysisSegue":
            return "プロジェクト別担当者"
        default:
            return ""
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkTypePreProjectAnalysisDetailSegue" {
            let destination = segue.destination as! WorkTypePreProjectAnalysisDetailController
            let sender = sender as! [String: Any?]
            let workTypePreProjectAnalysisDetailCollection = sender["data"] as? WorkTypePreProjectAnalysisCollection
            let project = sender["project"] as? Project
            destination.workTypePreProjectAnalysisDetails = workTypePreProjectAnalysisDetailCollection?.data
            destination.project = project
        }
        
        if segue.identifier == "UserPreProjectAnalysisDetailSegue" {
            let destination = segue.destination as! UserPreProjectAnalysisDetailController
            let sender = sender as! [String: Any?]
            let userPreProjectAnalysisDetailCollection = sender["data"] as? UserPreProjectAnalysisCollection
            let project = sender["project"] as? Project
            destination.userPreProjectAnalysisDetails = userPreProjectAnalysisDetailCollection?.data
            destination.project = project
        }
    }
    
}
