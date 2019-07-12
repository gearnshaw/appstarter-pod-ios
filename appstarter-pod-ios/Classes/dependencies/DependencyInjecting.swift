//
//  DependencyInjecting.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 08/07/2019.
//

import Foundation

/// A protocol that provides access to the dependency manager from anywhere
/// that needs access to it
public protocol DependencyInjecting {
    var dependencyManager: DependencyManager { get }
}

// MARK: - A default implementation that gets the dependency manager from the app context
public extension DependencyInjecting {
    var dependencyManager: DependencyManager {
        return AppContext.instance.dependencyManager
    }
}
