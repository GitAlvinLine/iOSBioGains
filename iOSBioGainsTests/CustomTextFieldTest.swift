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
        let sut = CustomTextField(placeholder: "Email")
        
        XCTAssertEqual(sut.placeholder, "Email")
    }
}
