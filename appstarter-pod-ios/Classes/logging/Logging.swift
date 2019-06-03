//
//  Logging.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 03/06/2019.
//

import Foundation

/// A protocol to allow logging in the app, whilst hiding the actual logging implementation
public protocol Logging {
    func debug(_ closure: @autoclosure () -> Any?)
    func info(_ closure: @autoclosure () -> Any?)
    func warning(_ closure: @autoclosure () -> Any?)
    func error(_ closure: @autoclosure () -> Any?)
}
