//
//  EditProfileController.swift
//  fourmix-system
//
//  Created by 高木駿 on 2019/07/29.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit
import KRProgressHUD

class EditProfileController: UITableViewController {
    
    var user: User!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.text = user.attributes.name
        emailField.text = user.attributes.email
    }
       
    @IBAction func updateButtonHasTapped(_ sender: Any) {
        KRProgressHUD.show()
        let userCreator  = UserCreator(name: nameField.text, oldPassword: nil, password: nil, passwordConform: nil)
        
        userCreator.updateProfile { (userData) in
            KRProgressHUD.dismiss()
            if let userData = userData {
                NotificationCenter.default.post(name: LocalNotificationService.profileHasUpdated, object: nil, userInfo: ["user": userData.data])
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Table view data source

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
