//
//  UITextFieldWithBorder.swift
//  Homepwner
//
//  Created by Jakub Kozlowicz on 09.06.19.
//  Copyright © 2019 Jakub Kozlowicz. All rights reserved.
//

import UIKit

class UITextFieldWithBorder: UITextField {
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .bezel
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        self.borderStyle = .roundedRect
        layer.borderColor = UIColor.red.cgColor
        return super.resignFirstResponder()
    }
    
}
