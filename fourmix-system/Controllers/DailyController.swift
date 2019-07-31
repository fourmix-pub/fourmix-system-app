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

    // 日報をスワイプした時のアクション
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集
        let editAction = UIContextualAction(style: .normal, title: "編集") { (_, _, _) in
            self.performSegue(withIdentifier: "DailyEditSegue", sender: self.dailies[indexPath.row])
        }
        // 削除
        let deleteAction = UIContextualAction(style: .normal, title: "削除") { (_, _, _) in
            let dailyCreator = DailyCreator(id: self.dailies[indexPath.row].id, workTypeId: nil, jobTypeId: nil, projectId: nil, date: nil, start: nil, end: nil, rest: nil, note: nil)
            dailyCreator.dailyDelete(callback: { (data) in
                if data! {
                    self.loadData()
                } else {
                    print("失敗しました")
                }
            })
        }
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    @IBAction func unwindToDailyList(unwindSngue: UIStoryboardSegue) {
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DailyEditSegue" {
            let destination = segue.destination as! UINavigationController
            let editDailyContoroller = destination.viewControllers.first as! EditDailyController
            editDailyContoroller.daily = sender as? Daily
        }
    }


}
