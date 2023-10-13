//
//  UserAccountVC.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 10/12/23.
//

import UIKit

class UserAccountVC: UIViewController {
    
    private let logoutButton: CustomButton = CustomButton(title: "Log Out")
    private let deleteAccountButton: CustomButton = CustomButton(title: "Delete Account")
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    let action: UIAlertAction = UIAlertAction(title: "OK", style: .default)
    private let user: User
    var authClient: AuthenticatorClient?
    var router: UINavigationController?
    
    init(user: User, authClient: AuthenticatorClient, router: UINavigationController) {
        self.user = user
        self.authClient = authClient
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("We are not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIScreen.main.traitCollection.userInterfaceStyle == .light ? .white : .black
        
        self.view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            logoutButton.bottomAnchor.constraint(equalTo: self.deleteAccountButton.topAnchor, constant: -20)
            
        ])
        
        logOutButtonSetup()
        
        deleteAccountButton.backgroundColor = .red
        deleteAccountButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(deleteAccountButton)
        
        NSLayoutConstraint.activate([
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 50),
            deleteAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            deleteAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            deleteAccountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        deleteAccountButtonSetup()
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 20),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        self.alert.addAction(action)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = previousTraitCollection?.userInterfaceStyle == .light ? .black : .white
    }
    
    private func logOutButtonSetup() {
        logoutButton.addTarget(self, action: #selector(logOutUser), for: .touchUpInside)
    }
    
    @objc private func logOutUser() {
        self.startAnimatingLoadingIndicator()
        authClient?.logOut { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.stopAnimatingLoadingIndicator()
                    
                    guard let client = self?.authClient,
                          let router = self?.router else { return }
                    
                    let loginVC = LoginViewController(authClient: client, router: router)
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self?.present(navigationController, animated: false)
                    
                case .failure(let error):
                    self?.stopAnimatingLoadingIndicator()
                    self?.showAlertError(error)
                }
            }
        }
    }
    
    private func deleteAccountButtonSetup() {
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountTapped), for: .touchUpInside)
    }
    
    @objc func deleteAccountTapped() {
        startAnimatingLoadingIndicator()
        authClient?.deleteUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.stopAnimatingLoadingIndicator()
                    
                    guard let client = self?.authClient,
                          let router = self?.router else { return }
                    
                    let loginVC = LoginViewController(authClient: client, router: router)
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self?.present(navigationController, animated: false)
                    
                case .failure(let error):
                    self?.stopAnimatingLoadingIndicator()
                    self?.showAlertError(error)
                }
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
