//
//  PreProjectAnalyticsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class PreProjectAnalyticsController: UITableViewController {

    var segueIdentifier: String!
    
    var projects: [Project] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        ProjectCollection.load { (projectCollection) in
            if let projectCollection = projectCollection {
                self.projects = projectCollection.data
                self.tableView.reloadData()
            }
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
            WorkTypePreProjectAnalysisCollection.load(query: query) { (workTypePreProjectAnalysisCollection) in
                if let workTypePreProjectAnalysisCollection = workTypePreProjectAnalysisCollection {
                    self.performSegue(withIdentifier: self.identifier(from: self.segueIdentifier), sender: [
                        "project": project,
                        "data": workTypePreProjectAnalysisCollection
                        ])
                }
            }
        } else {
            UserPreProjectAnalysisCollection.load(query: query) { (userPreProjectAnalysisCollection) in
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
