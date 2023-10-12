//
//  RoutingMananger.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 10/12/23.
//

import UIKit

final class RoutingManager {
    
    private let navigation: UINavigationController
    private let tabbar: UITabBarController
    private let authClient: AuthenticatorClient
    
    init(authClient: AuthenticatorClient, navigation: UINavigationController, tabbar: UITabBarController) {
        self.authClient = authClient
        self.navigation = navigation
        self.tabbar = tabbar
    }

}
