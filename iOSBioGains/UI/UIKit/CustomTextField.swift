//
//  CustomTextField.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/14/23.
//

import UIKit

class CustomTextField: UITextField {
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }
}
