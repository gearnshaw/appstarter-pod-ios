//
//  SizeProvider.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 02/06/2019.
//

import Foundation
import UIKit

/// A struct to make it easy to reference sizes when laying out UI
public struct SizeProvider {
    private let gridSpace: Double = 8

    public enum Name {
        case custom
        case grid // gridspace * 1
        case small // gridspace * 2
        case standard // gridspace * 4
        case menuIconOffset // gridspace * 5
    }

    // Public initialiser
    public init() {}

    /// Get a size for a given
    ///
    /// - Parameters:
    ///   - sizeName: the name of the size
    ///   - multiplier: the multiplier to multiply the size by
    /// - Returns: the CGFloat size
    public func getSize(sizeName: Name, multiplier: Double = 1) -> CGFloat {
        let retval: Double
        switch sizeName {
        case .custom,
             .grid:
            retval = gridSpace * multiplier
        case .small:
            retval = (gridSpace * 2) * multiplier
        case .standard:
            retval = (gridSpace * 4) * multiplier
        case .menuIconOffset:
            retval = (gridSpace * 5) * multiplier
        }

        return CGFloat(retval)
    }
}
