//
//  AuthenticatorClient.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import Foundation

struct AppUser {
    let email: String
    let name: String
}

enum AuthenticatorClientResult {
    case success(AppUser)
    case failure(Error)
}

protocol AuthenticatorClient {
    func authenticate(with email: String, and password: String, completion: @escaping (Result<AppUser, Error>) -> Void)
}
