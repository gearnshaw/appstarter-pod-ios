//
//  Comparable+extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 26/07/2019.
//

import Foundation

public extension Comparable {
    /// Clamp a comparable value to a given range.
    /// i.e. if the value is less than the lower bound, return the lower bound.
    /// If it is greater than the upper bound, return the upper bound
    ///
    /// - Parameter limits: the limits to clamp to
    /// - Returns: the clamped value
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
