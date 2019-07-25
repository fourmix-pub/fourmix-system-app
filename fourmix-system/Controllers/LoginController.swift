//
//  LoginController.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/25.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonHasTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Token.loginRequest(email: email, password: password) { (token) in
                if let token = token {
                    print(token)
                    //token.save()
                    //                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //                let controller = storyboard.instantiateViewController(withIdentifier: "MemoViewNav")
                    //                self.present(controller, animated: true)
                }
            }
        } else {
            showAlart(message: "メールアドレスとパスワードは必ず入力してください。")
        }
    }
    
    
    func setup() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func observes() {
        NotificationCenter.default.addObserver(forName: LocalNotificationService.unauthorized, object: nil, queue: nil) { (notification) in
            guard let message = notification.userInfo!["message"] else { return }
            
            self.showAlart(message: message as! String)
        }
    }
    
    func showAlart(message: String) {
        let alert = UIAlertController(title: "エラーです", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true)
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
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

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordField.becomeFirstResponder()
            break
        case 1:
            textField.resignFirstResponder()
            break
        default:
            break
        }
        
        return true
    }
}
