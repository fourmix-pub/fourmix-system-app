//
//  DailyViewController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class DailyViewController: UITableViewController {
    
    var user: User?
    var project: Project?
    var workType: WorkType?

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var workTypeNameLabel: UILabel!
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        observes()
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    func observes() {
        NotificationCenter.default.addObserver(forName: LocalNotificationService.userHasSelected, object: nil, queue: nil) { (notification) in
            guard let user = notification.userInfo!["user"] else { return }
            
            self.user = user as? User
            
            if let user = self.user {
                self.userNameLabel.text = user.attributes.name
            }
        }
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.projectHasSelected, object: nil, queue: nil) { (notification) in
            guard let project = notification.userInfo!["project"] else { return }
            
            self.project = project as? Project
            
            if let project = self.project {
                self.projectNameLabel.text = project.attributes.name
            }
        }
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.workTypeHasSelected, object: nil, queue: nil) { (notification) in
            guard let workType = notification.userInfo!["workType"] else { return }
            
            self.workType = workType as? WorkType
            
            if let workType = self.workType {
                self.workTypeNameLabel.text = workType.attributes.name
            }
        }
    }
    
    func setDatePicker() {
        self.startField.addTarget(self, action: #selector(self.startDateEditing), for: .editingDidBegin)
        self.endField.addTarget(self, action: #selector(self.endDateEditing), for: .editingDidBegin)
    }
    
    @objc func startDateEditing(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        if let date = Date.createFromFormat(string: sender.text ?? "") {
            datePickerView.setDate(date, animated: true)
        }
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.setStartFieldDate), for: .valueChanged)
    }
    
    @objc func endDateEditing(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        if let date = Date.createFromFormat(string: sender.text ?? "") {
            datePickerView.setDate(date, animated: true)
        }
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.setEndFieldDate), for: .valueChanged)
    }
    
    @objc func setStartFieldDate(sender: UIDatePicker) {
        self.startField.text = sender.date.format()
    }
    
    @objc func setEndFieldDate(sender: UIDatePicker) {
        self.endField.text = sender.date.format()
    }
    
    
    @IBAction func searchDailies(_ sender: Any) {
        
        let query:[String: Any] = [
            "filter[user_id]": user?.id ?? "",
            "filter[project_id]": project?.id ?? "",
            "filter[work_type_id]": workType?.id ?? "",
            "filter[started_time]": startField.text ?? "",
            "filter[ended_time]": endField.text ?? ""
        ]
        
        DailyCollection.load(query: query) { (dailyCollection) in
            if let dailyCollection = dailyCollection {
                self.performSegue(withIdentifier: "DailySearchResultsSegue", sender: dailyCollection)
            }
        }
    }
    
    @IBAction func clearButtonHasTapped(_ sender: Any) {
        self.user = nil
        self.project = nil
        self.workType = nil
        self.startField.text = nil
        self.endField.text = nil
        self.userNameLabel.text = "選択してください"
        self.projectNameLabel.text = "選択してください"
        self.workTypeNameLabel.text = "選択してください"
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DailySearchResultsSegue" {
            let destination = segue.destination as! DailyViewDetailController
            let dailyCollection = sender as? DailyCollection
            destination.dailies = dailyCollection?.data
        }
    }
}
