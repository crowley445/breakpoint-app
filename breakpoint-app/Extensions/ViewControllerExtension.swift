//
//  ViewControllerExtension.swift
//  breakpoint-app
//
//  Created by Brian  Crowley on 19/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func getButtonForInputAccessoryView(withTitle title: String, andImage image: UIImage?) -> UIButton {
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.1))
        btn.backgroundColor = CLR_KEYBOARD_BUTTON_BG
        btn.setTitleColor(CLR_KEYBOARD_BUTTON_TXT, for: .normal)
        btn.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: CLR_KEYBOARD_BUTTON_TXT, NSAttributedStringKey.font: UIFont.init(name: "Menlo-Bold", size: 24)!]), for: .normal)
        btn.setImage(image, for: .normal)
        return btn
    }
    
}
