//
//  PreUserAnalyticsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class PreUserAnalyticsController: UITableViewController {
    
    var segueIdentifier: String!

    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        UserCollection.load { (userCollection) in
            if let userCollection = userCollection {
                self.users = userCollection.data
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSearchCell", for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].attributes.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        self.performSegue(withIdentifier: identifier(from: segueIdentifier), sender: user)
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
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkTypePreUserAnalysisDetailSegue" {
            
        }
        
        if segue.identifier == "ProjectPreUserAnalysisDetailSegue" {
            
        }
     }
}
