//
//  CreatePostViewController.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 18/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit
import Firebase

class CreatePostViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var meassagePlaceholder : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        meassagePlaceholder = textView.text
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let message = textView.text, textView.text != "", textView.text != meassagePlaceholder else { return }
        DataService.instance.uploadPost(withMessage: message, forUID: (Auth.auth().currentUser?.uid)!, andGroupKey: nil) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("CREATE POST FAILED")
            }
        }
    }
}

extension CreatePostViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
