//
//  LoginViewControllerTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/12/23.
//

import XCTest
@testable import iOSBioGains

final class LoginViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_setLoginUIViewToSelfView() {
        let sut = LoginViewController()
        let loginView: UIView = LoginUIView()
        _ = sut.view
        
        XCTAssertEqual(sut.view.subviews.count, loginView.subviews.count)
    }
    
}
