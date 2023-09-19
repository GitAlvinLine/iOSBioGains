//
//  CustomProgressView.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/18/23.
//

import SwiftUI
import UIKit

class CustomProgressView: UIActivityIndicatorView {
    
    convenience init() {
        self.init(style: UIActivityIndicatorView.Style.large)
        self.color = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .black : .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.color = previousTraitCollection?.userInterfaceStyle == .light ? .white : .black
    }
}


struct ProgressView_Preview: PreviewProvider {
    struct ProgressView: UIViewRepresentable {
        func makeUIView(context: Context) -> CustomProgressView {
            return CustomProgressView()
        }
        
        func updateUIView(_ uiView: CustomProgressView, context: Context) {
            
        }
    }
    
    static var previews: some View {
        ProgressView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
