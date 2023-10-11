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
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    let action: UIAlertAction = UIAlertAction(title: "OK", style: .default)
    var user: User?
    var authClient: AuthenticatorClient?
    var logOutSuccess: (() -> Void)? = nil
    
    convenience init(user: User, authClient: AuthenticatorClient, logOutSuccess: @escaping () -> Void) {
        self.init()
        self.user = user
        self.authClient = authClient
        self.logOutSuccess = logOutSuccess
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
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        self.view.addSubview(loadingIndicator)
        
        self.alert.addAction(action)
        
    }
    
    private func logOutButtonSetup() {
        logoutButton.addTarget(self, action: #selector(logOutUser), for: .touchUpInside)
    }
    
    @objc private func logOutUser() {
        self.startAnimatingLoadingIndicator()
        authClient?.logOut { [weak self] result in
            switch result {
            case .success:
                self?.stopAnimatingLoadingIndicator()
                self?.logOutSuccess?()
            case .failure(let error):
                self?.stopAnimatingLoadingIndicator()
                self?.showAlertError(error)
            }
        }
    }
    
    private func startAnimatingLoadingIndicator() {
        self.loadingIndicator.startAnimating()
    }
    
    private func stopAnimatingLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
    }
    
    private func showAlertError(_ error: Error) {
        self.alert.title = "Error"
        self.alert.message = error.localizedDescription
        self.present(self.alert, animated: true)
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
