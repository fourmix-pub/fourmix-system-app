//
//  DailyController.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class DailyController: UITableViewController {

    var dailies: [Daily] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        DailyCollection.load { (dailyCollection) in
            if let dailyCollection = dailyCollection {
                self.dailies = dailyCollection.data
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    // セクションの行の数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dailies.count
    }

    // セルの指定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! DailyCell

        cell.update(daily: dailies[indexPath.row])

        return cell
    }

    /*
    // 日報をスワイプした時のアクション
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集
        let editAction = UIContextualAction(style: .normal, title: "編集") { (_, _, _) in
            <#code#>
        }
        // 削除
        let deleteAction = UIContextualAction(style: .normal, title: "削除") { (_, _, _) in
            let dailyCreator = DailyCreator(id: self.dailies[indexPath.row].id, workTypeId: nil, jobTypeId: nil, projectId: nil, date: nil, start: nil, end: nil, rest: nil, note: nil)
            
        }
    }
     */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
