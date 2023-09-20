//
//  HomeViewController.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    
    let homeLabel: UILabel = UILabel()
    let logoutButton: CustomButton = CustomButton(title: "Log Out")
    var tappedLogOut: (() -> Void)? = nil
    
    convenience init(tappedLogOut: @escaping () -> Void) {
        self.init()
        self.tappedLogOut = tappedLogOut
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        homeLabel.text = "Home"
        homeLabel.textColor = .black
        homeLabel.font = .preferredFont(forTextStyle: .largeTitle)
        homeLabel.textAlignment = .center
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(homeLabel)
        
        NSLayoutConstraint.activate([
            homeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            homeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            homeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            homeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
        
        self.view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            logoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
        
        logOutButtonSetup()
    }
    
    private func logOutButtonSetup() {
        logoutButton.addTarget(self, action: #selector(logOutUser), for: .touchUpInside)
    }
    
    @objc private func logOutUser() {
        tappedLogOut?()
    }

}

struct HomeVC_Preview: PreviewProvider {
    struct HomeVCView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> HomeViewController {
            return HomeViewController()
        }
        
        func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
            
        }
    }
    
    static var previews: some View {
        HomeVCView()
    }
}
