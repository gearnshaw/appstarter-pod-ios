//
//  Stub.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 09/07/2019.
//

import Foundation

/// A list of arbitrary callback labels to make it easy to specify the callback that should be invoked
public enum CallbackType {
    case success
    case error
}

/// A helper class to speed up hand-cranking mocks for testing
///
/// R is the return type of the method to stub
///     - Use 'Void' if there is no return type
/// P is the type of the parameters that the stubbed method is called with
///     - Use a tuple or typealias if there are multiple parameters
public class Stub<R, P> {

    // Configurable
    private var chainedReturns: [() -> R] = []
    private var finallyReturn: (() -> R)?
    public var retval: R
    public var throwVal: Error?
    public var callbackType: CallbackType? = .success
    public var callbacks: [CallbackType: MockExecutable] = [:]

    // Record
    fileprivate var _callCount = 0
    fileprivate var _calledWith: P?
    fileprivate var _calledWithHistory: [P] = []

    public init(defaultRetval: R) {
        retval = defaultRetval
    }

    // MARK: - Initialisation

    /// Set a value to return first.
    /// NB if return values have already been set with firstReturn / thenReturn, these
    /// will be cleared by calling this function
    ///
    /// - Parameter retval: the retval to return
    /// - Returns: the stub, so other setup can be chained
    public func firstReturn(retval: @escaping @autoclosure () -> R) -> Stub<R, P> {
        return firstReturn(retvalGenerator: retval)
    }

    /// Set a closure to generate on demand a value to return first.
    /// NB if return values have already been set with firstReturn / thenReturn, these
    /// will be cleared by calling this function
    ///
    /// - Parameter retvalGenerator: the closure to generate the retval
    /// - Returns: the stub, so other setup can be chained
    public func firstReturn(retvalGenerator: @escaping () -> R) -> Stub<R, P> {
        chainedReturns = []
        return thenReturn(retvalGenerator: retvalGenerator)
    }

    /// Set a value to return next.
    ///
    /// - Parameter retval: the retval to return
    /// - Returns: the stub, so other setup can be chained
    public func thenReturn(retval: @escaping @autoclosure () -> R) -> Stub<R, P> {
        return thenReturn(retvalGenerator: retval)
    }

    /// Set a closure to generate on demand a value to return next.
    ///
    /// - Parameter retvalGenerator: the closure to generate the retval
    /// - Returns: the stub, so other setup can be chained
    public func thenReturn(retvalGenerator: @escaping () -> R) -> Stub<R, P> {
        chainedReturns.append(retvalGenerator)
        return self
    }

    /// Set a value to always return (NB this is effectively the same as setting retval directly)
    ///
    /// - Parameter retval: the retval to return
    public func finallyAlwaysReturn(retval: @escaping @autoclosure () -> R) {
        finallyAlwaysReturn(retvalGenerator: retval)
    }

    /// Set a closure to generate on demand a value to always return
    /// (NB this is effectively the same as setting retval directly, except it can be used for generators rather
    /// than just return values)
    ///
    /// - Parameter retvalGenerator: the closure to generate the retval
    public func finallyAlwaysReturn(retvalGenerator: @escaping () -> R) {
        finallyReturn = retvalGenerator
    }

    // MARK: - Execution

    /// Called when anything is executed.
    ///
    /// Increment the call count and record the parameters
    ///
    /// - Parameter params: the parameters passed to the method
    fileprivate func recordExecution(params: P) {
        _callCount += 1
        _calledWith = params
        _calledWithHistory.append(params)
    }

    fileprivate func invokeCallback() {
        if let callbackType = callbackType {
            callbacks[callbackType]?.execute()
        }
    }

    /// Called in a mocked method that throws an exception
    ///
    /// - Parameter params: the parameters that the method was called with
    /// - Returns: the return value specified
    /// - Throws: the throwable specified
    public func executeAndThrow(params: P) throws -> R {
        recordExecution(params: params)

        // Throw an error if there was one
        if let error = throwVal {
            throw error
        }

        invokeCallback()
        return getRetval()
    }

    /// Called in the mocked method.
    /// Invoke a callback if one is specified, then return the retval.
    ///
    /// - Parameter params: the params to invoke the method with
    /// - Returns: the retval that has been specified
    public func executeWithoutThrowable(params: P) -> R {
        recordExecution(params: params)
        invokeCallback()
        return getRetval()
    }
}

// MARK: - Interrogated by the user after execution
public extension Stub {
    /// Interrogate to find how many times this stub was called
    var callCount: Int {
        return _callCount
    }

    /// Interrogate to find the last set of parameters that the method was called with
    var calledWith: P? {
        return _calledWith
    }

    /// Interrogate to find all parameters that the method was called with
    var calledWithHistory: [P] {
        return _calledWithHistory
    }
}

// MARK: - Helper functions
fileprivate extension Stub {

    /// Get the correct retval for the stub to return
    ///
    /// - Returns: the retval
    func getRetval() -> R {
        let retvalToUse: R

        // Chained returns
        if !chainedReturns.isEmpty {
            let retvalGenerator = chainedReturns.removeFirst()
            retvalToUse = retvalGenerator()
        } else if let finallyReturn = finallyReturn {
            retvalToUse = finallyReturn()
        } else {
            retvalToUse = retval
        }
        return retvalToUse
    }
}

/// A convenience implementation of a stub with no return value
public class StubWithNoReturnValue<P>: Stub<Void, P> {
    public init() {
        super.init(defaultRetval: Void())
    }
}
