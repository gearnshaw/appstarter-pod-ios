//
//  Logging.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 03/06/2019.
//

import Foundation
import XCGLogger

/// A protocol to allow logging in the app, whilst hiding the actual logging implementation
public protocol Logging {
    var logger: XCGLogger { get }
}

// MARK: - A default implementation of Logging that uses XCGLogger.
// NB if this is used in projects that _don't_ use XCGLogger, this default
// implementation should be removed so it isn't unnecessarily imported into projects.
public extension Logging {
    var logger: XCGLogger {
        return XCGLogger.default
    }
}
