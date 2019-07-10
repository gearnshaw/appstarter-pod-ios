//
//  StubTest.swift
//  appstarter-pod-ios_Tests
//
//  Created by Gabrielle Earnshaw on 09/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import appstarter_pod_ios

class StubTest: XCTestCase {
    private let someInt = 23
    private let someString = "sdfoij"
}

// MARK: - Return values
extension StubTest {
    func test_itShouldReturnDefaultRetval_whenNoOverrideRetvalIsSet() {
        // given
        let expected = "allsorts"
        let stub = Stub<String, Int>(defaultRetval: expected)

        // when
        let actual = stub.executeWithoutThrowable(params: someInt)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_itShouldReturnOverriddenRetval_whenSetWithFirstReturn() {
        // given
        let defaultRetval = "smarties"
        let stub = Stub<String, Int>(defaultRetval: defaultRetval)

        let expected = "allsorts"
        _ = stub.firstReturn(retval: expected)

        // when
        let actual = stub.executeWithoutThrowable(params: someInt)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_itShouldReturnOverriddenRetval_whenSetWithThenReturn() {
        // given
        let defaultRetval = "smarties"
        let stub = Stub<String, Int>(defaultRetval: defaultRetval)

        let expected = "allsorts"
        _ = stub.thenReturn(retval: expected)

        // when
        let actual = stub.executeWithoutThrowable(params: someInt)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_itShouldReturnOverriddenRetval_whenSetWithFinallyAlwaysReturn() {
        // given
        let defaultRetval = "smarties"
        let stub = Stub<String, Int>(defaultRetval: defaultRetval)

        let expected = "allsorts"
        stub.finallyAlwaysReturn(retval: expected)

        // when
        let actual = stub.executeWithoutThrowable(params: someInt)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_itShouldReturnDefaultRetval_whenOverriddenRetvals_haveAlreadyBeenReturned() {
        // given
        let expected = "smarties"
        let stub = Stub<String, Int>(defaultRetval: expected)

        let overriddenRetval = "allsorts"
        _ = stub.firstReturn(retval: overriddenRetval)

        // when
        _ = stub.executeWithoutThrowable(params: someInt)
        let actual = stub.executeWithoutThrowable(params: someInt)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_itShouldReturnFinalRetval_whenOtherOverriddenRetvals_haveAlreadyBeenReturned() {
        // given
        let defaultRetval = "spangles"
        let stub = Stub<String, Int>(defaultRetval: defaultRetval)

        let firstRetval = "allsorts"
        let expected = "smarties"
        stub.firstReturn(retval: firstRetval)
            .finallyAlwaysReturn(retval: expected)


        // when
        _ = stub.executeWithoutThrowable(params: someInt)
        _ = stub.executeWithoutThrowable(params: someInt)
        let actual = stub.executeWithoutThrowable(params: someInt)

        // then
        XCTAssertEqual(actual, expected)
    }

    func test_itShouldReturnRetvals_inCorrectOrder() {
        // given
        let defaultRetval = "spangles"
        let stub = Stub<String, Int>(defaultRetval: defaultRetval)

        let firstRetval = "allsorts"
        let secondRetval = "smarties"
        let thirdRetval = "ripple"
        stub.firstReturn(retval: firstRetval)
            .thenReturn(retval: secondRetval)
            .finallyAlwaysReturn(retval: thirdRetval)

        let expectedRetvals = [firstRetval,
                               secondRetval,
                               thirdRetval,
                               thirdRetval]

        // when
        let actualRetvals = (1...4).map { (_) -> String in
            stub.executeWithoutThrowable(params: someInt)
        }

        // then
        XCTAssertEqual(actualRetvals, expectedRetvals)
    }
}

// MARK: - Exceptions
extension StubTest {
    func test_itShouldNotThrowException_whenNoErrorIsSet() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)

        // when
        var errorCaught = false
        do {
            _ = try stub.executeAndThrow(params: someInt)
        } catch {
            errorCaught = true
        }

        // then
        XCTAssertFalse(errorCaught)
    }

    func test_itShouldThrowException_whenErrorIsSet() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)
        stub.throwVal = TestError.test

        // when
        var errorCaught = false
        do {
            _ = try stub.executeAndThrow(params: someInt)
        } catch {
            errorCaught = true
        }

        // then
        XCTAssertTrue(errorCaught)
    }
}

// MARK: - Recording
extension StubTest {
    func test_callCount_shouldBeZero_whenExecuteIsNotCalled() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)
        let expectedCallCount = 0

        // when
        let actual = stub.callCount

        // then
        XCTAssertEqual(actual, expectedCallCount)
    }

    func test_callCount_shouldBeEqualTo_numberOfTimesExecuteIsCalled() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)
        let numberOfTimesToCallFunction = 12

        // when
        (1...numberOfTimesToCallFunction).forEach { (_) in
            _ = stub.executeWithoutThrowable(params: someInt)
        }
        let actual = stub.callCount

        // then
        XCTAssertEqual(actual, numberOfTimesToCallFunction)
    }

    func test_calledWith_shouldBeNil_whenExecuteIsNotCalled() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)

        // when
        let actual = stub.calledWith

        // then
        XCTAssertNil(actual)
    }

    func test_calledWith_shouldBeEqualToParameters_whenExecuteIsCalled() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)
        let expectedCalledWith = 35

        // when
        _ = stub.executeWithoutThrowable(params: expectedCalledWith)
        let actual = stub.calledWith

        // then
        XCTAssertEqual(actual, expectedCalledWith)
    }

    func test_calledWith_shouldBeEqualToLastParameters_whenExecuteIsCalledMultipleTimes() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)
        let firstParams = 35
        let secondParams = 8
        let thirdParams = 83

        let allParams = [firstParams, secondParams, thirdParams]
        let expectedCalledWith = allParams.last

        // when
        allParams.forEach { (params) in
            _ = stub.executeWithoutThrowable(params: params)
        }
        let actual = stub.calledWith

        // then
        XCTAssertEqual(stub.callCount, allParams.count)
        XCTAssertEqual(actual, expectedCalledWith)
    }
}

// MARK: - Callbacks
extension StubTest {
    func test_itShouldInvokeCallback_ofCorrectCallbackType() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)

        // Create a callback
        let callback = Callback<Bool, Void>(defaultCallbackParams: false)
        let expectation = self.expectation(description: "Waiting for callback")
        callback.callback = { _ in
            expectation.fulfill()
        }

        // Add it to the stub
        let callbackType = CallbackType.success
        stub.callbackType = callbackType
        stub.callbacks[callbackType] = callback

        // when
        _ = stub.executeWithoutThrowable(params: someInt)

        // then
        waitForExpectations(timeout: 1) { (_) in
            // If we get here without error, our callback was called
        }
    }

    func test_itShouldNotInvokeCallback_ofDifferentCallbackType() {
        // given
        let stub = Stub<String, Int>(defaultRetval: someString)

        // Create a callback
        let callback = Callback<Bool, Void>(defaultCallbackParams: false)
        let expectation = self.expectation(description: "Waiting for callback")
        callback.callback = { _ in
            expectation.fulfill()
        }

        // Add it to the stub
        let callbackType = CallbackType.success
        stub.callbackType = callbackType

        let differentCallbackType = CallbackType.error
        stub.callbacks[differentCallbackType] = callback

        // We _don't_ expect this code to be called, so invert the expectation
        expectation.isInverted = true

        // when
        _ = stub.executeWithoutThrowable(params: someInt)

        // then
        waitForExpectations(timeout: 1) { (_) in
            // If we get here without error, our callback wasn't called
        }
    }
}

// MARK: - Retval generator
extension StubTest {
    // TODO: Implement
}

/// Used as an exception for testing throwables
enum TestError: Error {
    case test
}
