//
//  AuthViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 18/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
