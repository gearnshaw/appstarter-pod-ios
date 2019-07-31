//
//  SecureEndpoint.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 31/07/2019.
//

import Foundation

// A protocol to represent a secure endpoint, i.e. one that uses HTTPS as its scheme
public protocol SecureEndpoint: Endpoint {
    // No code
}

// Provide the implementation to return the scheme
public extension SecureEndpoint {
    var scheme: String {
        return "https"
    }
}
