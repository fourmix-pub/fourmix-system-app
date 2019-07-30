//
//  CreateDailyController.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class CreateDailyController: UITableViewController {

    var project: Project?
    var workType: WorkType?
    var jobType: JobType?

    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var workTypeNameLabel: UILabel!
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var restTimeField: UITextField!
    @IBOutlet weak var jobTypeNameLabel: UILabel!
    @IBOutlet weak var noteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setDatePicker()
        observes()
        
        tableView.keyboardDismissMode = .onDrag
    }
    
    func setup() {
        let now = Date()
        dateField.text = now.format()
        startField.text = now.format("HH:mm")
        endField.text = now.format("HH:mm")
    }
    
    // プロジェクト、作業分類、勤務分類を選択
    func observes() {
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
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.jobTypeHasSelected, object: nil, queue: nil) { (notification) in
            guard let jobType = notification.userInfo!["jobType"] else { return }
            
            self.jobType = jobType as? JobType
            
            if let jobType = self.jobType {
                self.jobTypeNameLabel.text = jobType.attributes.name
            }
        }
    }
    
    // 日付・時間入力
    func setDatePicker() {
        self.dateField.addTarget(self, action: #selector(self.dateEditing), for: .editingDidBegin)
        self.startField.addTarget(self, action: #selector(self.startTimeEditing), for: .editingDidBegin)
        self.endField.addTarget(self, action: #selector(self.endTimeEditing), for: .editingDidBegin)
    }
    
    @objc func dateEditing(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        if let date = Date.createFromFormat(string: sender.text ?? "") {
            datePickerView.setDate(date, animated: true)
        }
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.setDateFieldDate), for: .valueChanged)
    }
    
    @objc func startTimeEditing(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        if let date = Date.createFromFormat(string: sender.text ?? "", format: "HH:mm") {
            datePickerView.setDate(date, animated: true)
        }
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.setStartFieldDate), for: .valueChanged)
    }
    
    @objc func endTimeEditing(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        if let date = Date.createFromFormat(string: sender.text ?? "", format: "HH:mm") {
            datePickerView.setDate(date, animated: true)
        }
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.setEndFieldDate), for: .valueChanged)
    }
    
    @objc func setDateFieldDate(sender: UIDatePicker) {
        self.dateField.text = sender.date.format()
    }
    
    @objc func setStartFieldDate(sender: UIDatePicker) {
        self.startField.text = sender.date.format("HH:mm")
    }
    
    @objc func setEndFieldDate(sender: UIDatePicker) {
        self.endField.text = sender.date.format("HH:mm")
    }
    
    // 完了ボタン
    @IBAction func saveButtonHasTapped(_ sender: Any) {
        let dailyCreator = DailyCreator(id: nil, workTypeId: workType?.id, jobTypeId: jobType?.id, projectId: project?.id, date: dateField.text, start: startField.text, end: endField.text, rest: nil, note: noteView.text)
        
        dailyCreator.create { (daily) in
            if let daily = daily {
                NotificationCenter.default.post(name: LocalNotificationService.dailyHasCreated, object: nil, userInfo: ["daily": daily])
                self.performSegue(withIdentifier: "UnwindToDailyList", sender: self)
            }
        }
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
