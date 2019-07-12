//
//  AppContext.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 08/07/2019.
//

import Foundation

/// AppContext singleton. This can be used to store (minimum) state that can be accessed across the codebase
class AppContext {
    static let instance = AppContext()
    fileprivate init() {}

    var dependencyManager = DependencyManager()

    #if DEBUG
    var isDebug = true
    #else
    var isDebug = false
    #endif
}
