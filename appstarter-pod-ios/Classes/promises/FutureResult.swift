//
//  FutureResult.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 01/08/2019.
/// Implementation of futures and promises
/// From https://github.com/JohnSundell/SwiftBySundell/blob/master/Blog/Under-the-hood-of-Futures-and-Promises.swift
//

import Foundation

/// An enum representing the result of a value
///
/// - value: the value of the result
/// - error: the error
public enum FutureResult<Value> {
    case value(Value)
    case error(Error)
}
