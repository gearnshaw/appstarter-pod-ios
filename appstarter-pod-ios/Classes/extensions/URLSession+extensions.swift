//
//  URLSession+extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 31/07/2019.
//

import Foundation

/// An extension on URLSession that provides utility functions for common networking tasks
public extension URLSession {
    func request(_ endpoint: Endpoint, callback: @escaping ((Result<Data, Error>) -> Void)) {
        // Immediately reject the promise in case the passed
        // endpoint can't be converted into a valid URL
        guard let url = endpoint.url else {
            // TODO: Implement
            //            callback(.failure())
            return
        }

        let task = dataTask(with: url) { data, _, error in
            // Reject or resolve the promise, depending on the result
            if let error = error {
                callback(.failure(error))
            } else {
                callback(.success(data ?? Data()))
            }
        }

        task.resume()
    }
}
