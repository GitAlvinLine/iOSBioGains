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
        let app = App(id: "application-0-zyajh")
        let realmAuthClient: AuthenticatorClient = RealmAuthenticatorClient()
        let router = UINavigationController()
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        if let user = app.currentUser {
            let user = User(email: user.profile.email ?? "", name: user.profile.name ?? "")
            let homeVC = HomeViewController(user: user, authClient: realmAuthClient, router: router)
            router.viewControllers = [homeVC]
            self.window?.rootViewController = router
            self.window?.makeKeyAndVisible()
        } else {
            let loginVC = LoginViewController(authClient: realmAuthClient, router: router)
            router.viewControllers = [loginVC]
            self.window?.rootViewController = router
            self.window?.makeKeyAndVisible()
        }
        
    }

}
