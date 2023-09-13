//
//  LoginViewControllerTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/12/23.
//

import XCTest
@testable import iOSBioGains

final class LoginViewControllerTest: XCTestCase {

    func test_viewDidLoad_EmailTextFieldPlaceholder() {
        let sut = LoginViewController(emailPlaceholder: "Email")
        
        _ = sut.view
        
        XCTAssertEqual(sut.emailTextField.placeholder, "Email")
    }
}
