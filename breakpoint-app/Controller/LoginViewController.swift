//
//  LoginViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 18/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signInPressed (_ sender: UIButton) {
        
        guard let email = emailField.text, emailField.text != "" else { return }
        guard let password = passwordField.text, passwordField.text != "" else { return }
        
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
            if !success {
                AuthService.instance.registerUser(withEmail: email, andPassword: password, completion: { (registerSuccess, registerError) in
                    if registerSuccess {
                        AuthService.instance.loginUser(withEmail: email, andPassword: password, completion: { (loginSuccess, loginError) in
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        debugPrint("FAILED REGISTER: \(String(describing: registerError?.localizedDescription))")
                    }
                })
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func closePressed (_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}
