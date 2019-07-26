//
//  SettingsController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/26.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
