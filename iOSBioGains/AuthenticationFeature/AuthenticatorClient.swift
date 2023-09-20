//
//  AuthenticatorClient.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/19/23.
//

import Foundation

enum AuthenticatorClientResult {
    case success(Data)
    case failure(Error)
}

protocol AuthenticatorClient {
    func authenticate(with email: String, and password: String, completion: @escaping (Result<Data, Error>) -> Void)
}
