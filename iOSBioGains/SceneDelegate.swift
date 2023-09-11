//
//  SceneDelegate.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/10/23.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let loginView = LoginView()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: loginView)
        self.window = window
        window.makeKeyAndVisible()
    }
}