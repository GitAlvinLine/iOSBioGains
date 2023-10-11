//
//  SceneDelegate.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/10/23.
//

import RealmSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let realmAuthClient: AuthenticatorClient = RealmAuthenticatorClient()
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        self.window?.rootViewController = LoginViewController(authClient: realmAuthClient) { user in
            
        }
        
        self.window?.makeKeyAndVisible()
    }
}
