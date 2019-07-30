//
//  SettingsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/26.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    var user: User?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        observes()
    }
    
    func loadData() {
        UserData.getProfile { (userDate) in
            if let userDate = userDate {
                self.user = userDate.data
                self.userNameLabel.text = userDate.data.attributes.name
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let user = self.user, indexPath.row == 0 && indexPath.section == 0 {
            self.performSegue(withIdentifier: "EditProfileSegue", sender: user)
        }
        if let user = self.user, indexPath.row == 1 && indexPath.section == 0 {
            self.performSegue(withIdentifier: "ResetPasswordSegue", sender: user)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: "ログアウトしますか？", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (_) in
                actionSheet.dismiss(animated: true)
            }
            
            let logoutAction = UIAlertAction(title: "ログアウト", style: .default) { (_) in
                if Token.logout() {
                    let storyBoard = UIStoryboard(name: "Login", bundle: nil)
                    let loginController = storyBoard.instantiateViewController(withIdentifier: "loginView")
                    UIApplication.shared.keyWindow?.rootViewController = loginController
                }
            }
            
            logoutAction.setValue(UIColor.red, forKey: "titleTextColor")
            
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(logoutAction)
            
            self.present(actionSheet, animated: true)
        }
        
    }
    
    func observes() {
        NotificationCenter.default.addObserver(forName: LocalNotificationService.profileHasUpdated, object: nil, queue: nil) { (notification) in
            guard let user = notification.userInfo!["user"] else { return }
            
            self.user = user as? User
            self.userNameLabel.text = self.user?.attributes.name
        }
        
        NotificationCenter.default.addObserver(forName: LocalNotificationService.passwordHasReset, object: nil, queue: nil) { (notification) in
            guard let user = notification.userInfo!["user"] else { return }
            
            self.user = user as? User
            self.userNameLabel.text = self.user?.attributes.name
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditProfileSegue" {
            let destination = segue.destination as! EditProfileController
            destination.user = sender as? User
        }
        if segue.identifier == "ResetPasswordSegue" {
            let destination = segue.destination as! ResetPasswordController
            destination.user = sender as? User
        }
    }
}
