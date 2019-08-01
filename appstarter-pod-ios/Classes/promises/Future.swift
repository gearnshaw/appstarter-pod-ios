//
//  Future.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 01/08/2019.
//

import Foundation

/// Implementation of futures and promises
/// From https://github.com/JohnSundell/SwiftBySundell/blob/master/Blog/Under-the-hood-of-Futures-and-Promises.swift
public class Future<Value> {
    public typealias Callback = (FutureResult<Value>) -> Void

    var result: FutureResult<Value>? {
        didSet {
            result.map(report)
        }
    }
    private lazy var callbacks = [Callback]()

    public func observe(with callback: @escaping Callback) {
        callbacks.append(callback)
        result.map(callback)
    }

    /// Notify the callbacks that the result has been set
    ///
    /// - Parameter result: the result
    private func report(result: FutureResult<Value>) {
        for callback in callbacks {
            callback(result)
        }
    }
}

// MARK: - An extension on futures that adds some utility methods
public extension Future {
    /// Allows chaining of futures
    ///
    /// - Parameter closure: the closure
    /// - Returns: A chained future
    func chained<NextValue>(with closure: @escaping (Value) throws -> Future<NextValue>) -> Future<NextValue> {
        let promise = Promise<NextValue>()

        observe { result in
            switch result {
            case .value(let value):
                do {
                    let future = try closure(value)

                    future.observe { result in
                        switch result {
                        case .value(let value):
                            promise.resolve(with: value)
                        case .error(let error):
                            promise.reject(with: error)
                        }
                    }
                } catch {
                    promise.reject(with: error)
                }
            case .error(let error):
                promise.reject(with: error)
            }
        }

        return promise
    }

    /// Allow a promise to be transformed
    ///
    /// - Parameter closure: the closure
    /// - Returns: the transformed future
    func transformed<NextValue>(with closure: @escaping (Value) throws -> NextValue) -> Future<NextValue> {
        return chained { value in
            return try Promise(value: closure(value))
        }
    }
}

// MARK: - An extension on future that will decode data
public extension Future where Value == Data {
    func decoded<T: Decodable>() -> Future<T> {
        return transformed(with: {
            try JSONDecoder().decode(T.self, from: $0)
        })
    }
}
