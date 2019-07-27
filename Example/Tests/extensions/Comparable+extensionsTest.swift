//
//  Comparable+extensionsTest.swift
//  appstarter-pod-ios_Tests
//
//  Created by Gabrielle Earnshaw on 27/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import appstarter_pod_ios

class Comparable_extensionsTest: XCTestCase {
    func test_clamped_shouldReturnOriginalValue_whenWithinLimits() {
        // given
        let value = 10
        let lowerLimit = 5
        let upperLimit = 15
        let expected = value

        // when
        let actual = value.clamped(to: lowerLimit...upperLimit)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_clamped_shouldReturnLowerBound_whenValueIsLessThanLowerBound() {
        // given
        let value = 2
        let lowerLimit = 5
        let upperLimit = 15
        let expected = lowerLimit

        // when
        let actual = value.clamped(to: lowerLimit...upperLimit)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_clamped_shouldReturnUpperBound_whenValueIsGreaterThanUpperBound() {
        // given
        let value = 20
        let lowerLimit = 5
        let upperLimit = 15
        let expected = upperLimit

        // when
        let actual = value.clamped(to: lowerLimit...upperLimit)

        // then
        XCTAssertEqual(actual, expected)
    }
}
