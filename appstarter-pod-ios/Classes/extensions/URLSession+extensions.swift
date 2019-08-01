//
//  URLSession+extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 31/07/2019.
//

import Foundation

/// An extension on URLSession that provides utility functions for common networking tasks
public extension URLSession {
    /// Make a request for a given endpoint object.
    /// NB this implementation uses promises
    ///
    /// - Parameter endpoint: the endpoint
    /// - Returns: A futures
    func request(_ endpoint: Endpoint) -> Future<Data> {

        let promise = Promise<Data>()
        // Immediately reject the promise in case the passed
        // endpoint can't be converted into a valid URL
        guard let url = endpoint.url else {
            promise.reject(with: NetworkingError.invalidUrl)
            return promise
        }

        let task = dataTask(with: url) { data, _, error in
            // Reject or resolve the promise, depending on the result
            if let error = error {
                promise.reject(with: error)
            } else {
                promise.resolve(with: data ?? Data())
            }
        }

        task.resume()
        return promise
    }
}
