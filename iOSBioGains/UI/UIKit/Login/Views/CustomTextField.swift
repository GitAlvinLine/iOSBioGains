//
//  CustomTextField.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/14/23.
//

import UIKit
import SwiftUI

class CustomTextField: UITextField {
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    convenience init(placeholder: String, keyboardType: UIKeyboardType, secureTextEntry: Bool = false) {
        self.init()
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = secureTextEntry
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.font = UIFont.preferredFont(forTextStyle: .title3)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.layer.borderColor = previousTraitCollection?.userInterfaceStyle == .light ? UIColor.black.cgColor : UIColor.white.cgColor
        
    }
}

struct CustomTextField_Preview: PreviewProvider {
    private struct CustomTextFieldView: UIViewRepresentable {
        
        func makeUIView(context: Context) -> CustomTextField {
            return CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
        }
        
        func updateUIView(_ uiView: CustomTextField, context: Context) {
            
        }
        
    }
    
    static var previews: some View {
        CustomTextFieldView()
            .padding()
            .previewLayout(.fixed(width: 500, height: 100))
    }
}
