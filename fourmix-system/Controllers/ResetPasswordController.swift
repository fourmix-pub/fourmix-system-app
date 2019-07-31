//
//  ResetPasswordController.swift
//  fourmix-system
//
//  Created by 高木駿 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class ResetPasswordController: UITableViewController {

    var user: User!
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    
    @IBAction func resetButtonHasTapped(_ sender: Any) {
        let userCreator = UserCreator(name: nil, oldPassword: oldPassword.text, password: newPassword.text, passwordConform: confirmPassword.text)
        
            userCreator.updateProfile { (userData) in
                if let userData = userData {
                NotificationCenter.default.post(name: LocalNotificationService.passwordHasReset, object: nil, userInfo: ["user": userData.data])
                self.navigationController?.popViewController(animated: true)
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
