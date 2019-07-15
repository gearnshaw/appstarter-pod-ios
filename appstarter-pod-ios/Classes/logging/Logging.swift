//
//  Logging.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 03/06/2019.
//

import Foundation

/// A protocol to allow logging in the app, whilst hiding the actual logging implementation
public protocol Logging {
    func logDebug(_ closure: @autoclosure () -> Any?)
    func logInfo(_ closure: @autoclosure () -> Any?)
    func logWarning(_ closure: @autoclosure () -> Any?)
    func logError(_ closure: @autoclosure () -> Any?)
}
