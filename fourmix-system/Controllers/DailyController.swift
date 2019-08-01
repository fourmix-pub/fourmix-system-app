//
//  DailyController.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import KRProgressHUD

class DailyController: UITableViewController {

    var dailies: [Daily] = []
    var dailyCollection: DailyCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        observes()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
    }

    @objc func loadData() {
        KRProgressHUD.show()
        DailyCollection.load { (dailyCollection) in
            if let dailyCollection = dailyCollection {
                KRProgressHUD.dismiss()
                self.dailies = dailyCollection.data
                self.dailyCollection = dailyCollection
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    func loadMoreData(url: String) {
        KRProgressHUD.show()
        NetworkProvider.main.data(request: .loadFrom(url: url)) { (data) in
            KRProgressHUD.dismiss()
            if let data = data {
                let corder = JSONDecoder()
                let dailyCollection = try? corder.decode(DailyCollection.self, from: data)
                if let dailyCollection = dailyCollection {
                    self.dailyCollection = dailyCollection
                    self.dailies.append(contentsOf: dailyCollection.data)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func observes() {
        NotificationCenter.default.addObserver(forName: LocalNotificationService.dailyHasCreated, object: nil, queue: nil) { (notification) in
            guard let daily = notification.userInfo!["daily"] else { return }
            
            self.dailies.insert(daily as! Daily, at: 0)
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.dailyHasUpdated, object: nil, queue: nil) { (notification) in
            guard let daily = notification.userInfo!["daily"] else { return }
            
            if let index = self.dailies.firstIndex(where: { $0.id == (daily as! Daily).id}) {
                self.dailies[index] = daily as! Daily
            }
            
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: LocalNotificationService.dailyHasDeleted, object: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dailies.count
    }

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
            let alertView = UIAlertController(title: nil, message: "日報を削除します、よろしいですか？", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: { (_) in
                alertView.dismiss(animated: true)
            })
            
            let deleteAction = UIAlertAction(title: "削除", style: .default, handler: { (_) in
                let dailyCreator = DailyCreator(id: self.dailies[indexPath.row].id,
                                                workTypeId: nil,
                                                jobTypeId: nil,
                                                projectId: nil,
                                                date: nil,
                                                start: nil,
                                                end: nil,
                                                rest: nil,
                                                note: nil)
                dailyCreator.dailyDelete(callback: { (result) in
                    if result {
                        NotificationCenter.default.post(name: LocalNotificationService.dailyHasDeleted, object: nil)
                    }
                })
            })
            
            alertView.addAction(cancelAction)
            alertView.addAction(deleteAction)
            
            self.present(alertView, animated: true)
        }
        editAction.backgroundColor = UIColor(named: "brand-blue")
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dailyCollection = dailyCollection {
            let lastCell = self.dailies.count - 1
            if lastCell == indexPath.row {
                guard let nextUrl = dailyCollection.links.next else {
                    return
                }
                
                self.loadMoreData(url: nextUrl)
            }
        }
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
