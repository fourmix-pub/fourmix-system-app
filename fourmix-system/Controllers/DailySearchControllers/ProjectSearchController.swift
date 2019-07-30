//
//  ProjectSearchController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class ProjectSearchController: UITableViewController {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectSearchCell", for: indexPath)
        
        cell.textLabel?.text = projects[indexPath.row].attributes.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        NotificationCenter.default.post(name: LocalNotificationService.projectHasSelected, object: nil, userInfo: [
            "project": project])
        self.navigationController?.popViewController(animated: true)
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
