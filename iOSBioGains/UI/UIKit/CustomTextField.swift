//
//  CustomTextField.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/14/23.
//

import UIKit
import SwiftUI

class CustomTextField: UITextField {
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }
}

struct CustomTextFieldView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomTextField {
        return CustomTextField(placeholder: "Email")
    }
    
    func updateUIView(_ uiView: CustomTextField, context: Context) {
        
    }
    
}

struct CustomTextFieldPreview: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView()
    }
}
