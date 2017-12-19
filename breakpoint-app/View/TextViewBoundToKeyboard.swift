//
//  TextViewBoundToKeyboard.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 19/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class TextViewBoundToKeyboard: UITextView {

    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            let space = deltaY + 10
            self.frame.size = CGSize(width: self.frame.width, height: self.frame.height - space)
           
        }, completion: nil)
    }

}
