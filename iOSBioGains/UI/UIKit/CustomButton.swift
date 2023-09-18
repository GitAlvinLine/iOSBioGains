//
//  CustomButton.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/17/23.
//

import UIKit

class CustomButton: UIButton {
    
    convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let bgColor = previousTraitCollection?.userInterfaceStyle == .light ? UIColor.white : UIColor.black
        self.backgroundColor = bgColor
        
        let titleColor = previousTraitCollection?.userInterfaceStyle == .light ? UIColor.black : UIColor.white
        self.setTitleColor(titleColor, for: .normal)
        self.layer.borderColor = titleColor.cgColor
    }
    
}

import SwiftUI

struct CustomButtonViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIButton {
        return CustomButton(title: "Login")
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        
    }
}

struct CustomButtonView_Preview: PreviewProvider {
    static var previews: some View {
        CustomButtonViewRepresentable()
            .previewLayout(.fixed(width: 500, height: 100))
            .padding()
    }
}
