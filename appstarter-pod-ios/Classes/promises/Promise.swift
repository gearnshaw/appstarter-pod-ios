//
//  Promise.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 01/08/2019.
//

import Foundation

/// The promise class
public class Promise<Value>: Future<Value> {
    public init(value: Value? = nil) {
        super.init()
        result = value.map(FutureResult.value)
    }

    /// Resolve the promise
    ///
    /// - Parameter value: the value to resolve with
    public func resolve(with value: Value) {
        result = .value(value)
    }

    /// Reject the promise
    ///
    /// - Parameter error: the error to reject with
    public func reject(with error: Error) {
        result = .error(error)
    }
}
