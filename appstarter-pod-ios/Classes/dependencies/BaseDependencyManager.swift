//
//  BaseDependencyManager.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 08/07/2019.
//

import Foundation

/// The class that handles dependency management
open class BaseDependencyManager {

    // Public initialiser
    public init() {}

    // MARK: - Singleton variables
//    public lazy var myString: String = {
//        return ""
//    }()

    // MARK: - Factoried variables
    public var sizeProvider: SizeProvider {
        return SizeProvider()
    }

}
