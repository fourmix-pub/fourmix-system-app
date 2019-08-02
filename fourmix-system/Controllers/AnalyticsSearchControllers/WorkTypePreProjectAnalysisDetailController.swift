//
//  WorkTypePreProjectAnalysisDetailController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/08/01.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class WorkTypePreProjectAnalysisDetailController: UITableViewController {

    var workTypePreProjectAnalysisDetails: [WorkTypePreProjectAnalysis]!
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = project.attributes.name
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workTypePreProjectAnalysisDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalyticsCell", for: indexPath)
        
        let analysis = workTypePreProjectAnalysisDetails[indexPath.row]
        cell.textLabel?.text = "\(analysis.attributes.workType)（\(analysis.attributes.workTime) 時間）"
        cell.detailTextLabel?.text = "¥\(analysis.attributes.workCostWithFormat)"
        
        return cell
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
