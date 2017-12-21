//
//  AuthViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 18/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
        
    }
    
    @IBAction func googleLoginPressed(_ sender: Any) {
        
    }
    
    @IBAction func emailLoginPressed(_ sender: Any) {
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: ID_SB_LOGINVC) {
            present(loginVC, animated: true, completion: nil)
        }
    }
}
