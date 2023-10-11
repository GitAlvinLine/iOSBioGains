//
//  AuthenticatorClient.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import Foundation

struct User {
    let email: String
    let name: String
}

enum AuthenticatorClientResult {
    case success(User)
    case failure(Error)
}

protocol AuthenticatorClient {
    func authenticate(with email: String, and password: String, completion: @escaping (Result<User, Error>) -> Void)
}
