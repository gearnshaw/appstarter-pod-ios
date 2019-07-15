//
//  Logging+Extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 03/06/2019.
//

import Foundation
import XCGLogger

// MARK: - A default implementation of Logging that uses XCGLogger.
// NB if this is used in projects that _don't_ use XCGLogger, this default
// implementation should be removed so it isn't unnecessarily imported into projects.
public extension Logging {
    func logDebug(_ closure: @autoclosure () -> Any?) {
        XCGLogger.default.debug(closure: closure)
    }

    func logInfo(_ closure: @autoclosure () -> Any?) {
        XCGLogger.default.info(closure: closure)
    }

    func logWarning(_ closure: @autoclosure () -> Any?) {
        XCGLogger.default.warning(closure: closure)
    }

    func logError(_ closure: @autoclosure () -> Any?) {
        XCGLogger.default.error(closure: closure)
    }
}
