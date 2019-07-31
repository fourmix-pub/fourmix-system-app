//
//  AnalyticsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class AnalyticsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "UserPreProjectAnalysisSegue", "WorkTypePreProjectAnalysisSegue":
            break
        case "ProjectPreUserAnalysisSegue", "WorkTypePreUserAnalysisSegue":
            let destination = segue.destination as! PreUserAnalyticsController
            destination.segueIdentifier = segue.identifier
        default:
            break
        }
    }
}
