//
//  Calendar+extensionsTest.swift
//  appstarter-pod-ios_Tests
//
//  Created by Gabrielle Earnshaw on 07/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import appstarter_pod_ios

class Calendar_extensionsTest: XCTestCase {
    private var calendar: Calendar?

    override func setUp() {
        calendar = Calendar.current
    }
}

extension Calendar_extensionsTest {
    func test_getUniqueDays_shouldReturnEmptyArray_whenPassedEmptyArray() {
        // given
        guard let calendar = calendar else {
            XCTFail("Tests not set up correctly")
            return
        }

        let dateds: [Dated] = []
        let expectedUniqueDateCount = 0

        // when
        let actual = calendar.getUniqueDays(dateds: dateds)

        // then
        XCTAssertEqual(actual.count, expectedUniqueDateCount)
    }

    func test_getUniqueDays_shouldReturnOneEntry_forCorrectDay_whenOneDatedIsPassed() {
        // given
        guard let calendar = calendar else {
            XCTFail("Tests not set up correctly")
            return
        }

        let dateComponents = DateComponents(calendar: calendar,
                                            year: 2019,
                                            month: 8,
                                            day: 7, hour: 12, minute: 0)
        guard let date = calendar.date(from: dateComponents) else {
            XCTFail("Tests not set up correctly")
            return
        }
        let dated1 = TestDated(date: date)
        let dateds: [Dated] = [dated1]
        let expectedUniqueDateCount = 1

        // when
        let actual = calendar.getUniqueDays(dateds: dateds)

        // then
        XCTAssertEqual(actual.count, expectedUniqueDateCount)
    }

    func test_getUniqueDays_shouldReturnOneEntry_whenMultipleDatesArePassed_withSameDate() {
        // given
        guard let calendar = calendar else {
            XCTFail("Tests not set up correctly")
            return
        }

        let dateComponents = DateComponents(calendar: calendar,
                                            year: 2019,
                                            month: 8,
                                            day: 7, hour: 1, minute: 0)
        guard
            let date1 = calendar.date(from: dateComponents),
            let date2 = calendar.date(byAdding: .hour, value: 1, to: date1),
            let date3 = calendar.date(byAdding: .hour, value: 1, to: date2)
            else {
                XCTFail("Tests not set up correctly")
                return
        }

        let dateds = [date1, date2, date3].map {
            TestDated(date: $0)
        }
        let expectedUniqueDateCount = 1

        // when
        let actual = calendar.getUniqueDays(dateds: dateds)

        // then
        XCTAssertEqual(actual.count, expectedUniqueDateCount)
    }

    func test_getUniqueDays_shouldReturnAnEntry_forEveryUniqueDatePassed() {
        // given
        guard let calendar = calendar else {
            XCTFail("Tests not set up correctly")
            return
        }

        let dateComponents = DateComponents(calendar: calendar,
                                            year: 2019,
                                            month: 8,
                                            day: 7, hour: 1, minute: 0)
        guard
            let day1Date1 = calendar.date(from: dateComponents),
            let day1Date2 = calendar.date(byAdding: .hour, value: 1, to: day1Date1),
            let day2Date3 = calendar.date(byAdding: .day, value: 1, to: day1Date1),
            let day3Date4 = calendar.date(byAdding: .day, value: 2, to: day1Date1)
            else {
                XCTFail("Tests not set up correctly")
                return
        }

        let dateds = [day1Date1, day1Date2, day2Date3, day3Date4].map {
            TestDated(date: $0)
        }
        let expectedUniqueDateCount = 3

        // when
        let actual = calendar.getUniqueDays(dateds: dateds)

        // then
        XCTAssertEqual(actual.count, expectedUniqueDateCount)
    }
}

struct TestDated: Dated {
    var date: Date
}
