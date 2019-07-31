//
//  Endpoint.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 31/07/2019.
//

import Foundation

// A protocol to represent a URL request endpoint
public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

// An extension to build and expose the URL represented by the endpoint
public extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
