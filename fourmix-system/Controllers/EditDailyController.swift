//
//  EditDailyController.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/31.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import KRProgressHUD

class EditDailyController: UITableViewController {
    
    var daily: Daily!
    var project: Project?
    var workType: WorkType?
    var jobType: JobType?
    
    var projects: [Project] = []
    var workTypes: [WorkType] = []
    var jobTypes: [JobType] = []
    
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
        loadData()
        updateUI()
        setDatePicker()
        observes()
        
        tableView.keyboardDismissMode = .onDrag
    }
    
    func loadData() {
        KRProgressHUD.show()
        
        DispatchQueue.main.async {
            ProjectCollection.load { (projectCollection) in
                if let projectCollection = projectCollection {
                    self.projects = projectCollection.data
                    if self.projects.count > 0 && self.workTypes.count > 0 && self.jobTypes.count > 0 {
                        KRProgressHUD.dismiss()
                    }
                }
            }
            
            WorkTypeCollection.load { (workTypeCollection) in
                if let workTypeCollection = workTypeCollection {
                    self.workTypes = workTypeCollection.data
                    if self.projects.count > 0 && self.workTypes.count > 0 && self.jobTypes.count > 0 {
                        KRProgressHUD.dismiss()
                    }
                }
            }
            
            JobTypeCollection.load { (jobTypeCollection) in
                if let jobTypeCollection = jobTypeCollection {
                    self.jobTypes = jobTypeCollection.data
                    if self.projects.count > 0 && self.workTypes.count > 0 && self.jobTypes.count > 0 {
                        KRProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
    func updateUI() {
        dateField.text = Date.createFromFormat(string: daily.attributes.date, format: "yyyy-MM-dd HH:mm:ss")?.format("yyyy-MM-dd")
        projectNameLabel.text = daily.relationships.project.attributes.name
        workTypeNameLabel.text = daily.relationships.workType.attributes.name
        startField.text = Date.createFromFormat(string: daily.attributes.start, format: "HH:mm:ss")?.format("HH:mm")
        endField.text = Date.createFromFormat(string: daily.attributes.end, format: "HH:mm:ss")?.format("HH:mm")
        restTimeField.text = daily.attributes.rest?.description
        jobTypeNameLabel.text = daily.relationships.jobType.attributes.name
        noteView.text = daily.attributes.note
        project = daily.relationships.project
        workType = daily.relationships.workType
        jobType = daily.relationships.jobType
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
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.inputError, object: nil, queue: nil) { (notification) in
            guard let message = notification.userInfo!["message"] else { return }
            
            let alert = UIAlertController(title: "エラーです", message: message as? String, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                alert.dismiss(animated: true)
            })
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
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
    
    // 更新ボタン
    @IBAction func updateButtonHasTapped(_ sender: Any) {
        KRProgressHUD.show()
        let dailyCreator = DailyCreator(id: daily.id,
                                        workTypeId: workType?.id,
                                        jobTypeId: jobType?.id,
                                        projectId: project?.id,
                                        date: dateField.text,
                                        start: startField.text,
                                        end: endField.text,
                                        rest: Int(restTimeField.text ?? ""),
                                        note: noteView.text)
        
        dailyCreator.dailyUpdate { (daily) in
            KRProgressHUD.dismiss()
            if let daily = daily {
                NotificationCenter.default.post(name: LocalNotificationService.dailyHasUpdated, object: nil, userInfo: ["daily": daily])
                self.performSegue(withIdentifier: "UnwindToDailyListFromEditView", sender: self)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ProjectNameSegue":
            let destination = segue.destination as! ProjectSearchController
            destination.projects = self.projects
            break
        case "WorkTypeSegue":
            let destination = segue.destination as! WorkTypeSearchController
            destination.workTypes = self.workTypes
            break
        case "JobTypeSegue":
            let destination = segue.destination as! JobTypeSearchController
            destination.jobTypes = self.jobTypes
            break
        default:
            break
        }
    }
}
