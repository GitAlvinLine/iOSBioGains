//
//  CustomTextFieldTest.swift
//  iOSBioGainsTests
//
//  Created by Alvin Escobar on 9/14/23.
//

import XCTest
import UIKit
@testable import iOSBioGains

final class CustomTextFieldTest: XCTestCase {
    
    func test_init_withPlaceholder() {
        let sut = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
        
        XCTAssertEqual(sut.placeholder, "Email")
    }
    
    func test_init_setKeyboardType() {
        let sut = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
        
        XCTAssertEqual(sut.keyboardType, .emailAddress)
    }
    
    func test_init_setSecureTextEntry() {
        let sut = CustomTextField(placeholder: "Email", keyboardType: .emailAddress, secureTextEntry: true)
        
        XCTAssertEqual(sut.isSecureTextEntry, true)
        
        let sut2 = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
        
        XCTAssertEqual(sut2.isSecureTextEntry, false)
    }
    
    func test_init_configureWithBlackRoundedBorderUI() {
        let sut = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    }
}
