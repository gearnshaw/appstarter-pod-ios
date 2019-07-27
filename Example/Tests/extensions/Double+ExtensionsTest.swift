//
//  Double+ExtensionsTest.swift
//  appstarter-pod-ios_Tests
//
//  Created by Gabrielle Earnshaw on 27/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class Double_ExtensionsTest: XCTestCase {

    func test_toInt_shouldReturn_intEquivalentOfValue() {
        // given
        let value = 10.0
        let expected = 10

        // when
        let actual = value.toInt()

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_toInt_shouldTruncate_decimalPlacesToReturnInt() {
        // given
        let value = 10.9
        let expected = 10

        // when
        let actual = value.toInt()

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_toInt_shouldReturnNil_ifValueIsOutsideIntRange() {
        // given
        let value = Double.greatestFiniteMagnitude
        let expected: Int? = nil

        // when
        let actual = value.toInt()

        // then
        XCTAssertEqual(actual, expected)
    }
}
