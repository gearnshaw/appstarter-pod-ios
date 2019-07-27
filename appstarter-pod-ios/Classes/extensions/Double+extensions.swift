//
//  Double+extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 26/07/2019.
//

import Foundation

public extension Double {
    /// Convert a double to an integer.
    /// Source: https://stackoverflow.com/a/40544010
    /// NB this will truncate decimal places, e.g. 10.9 will become 10
    ///
    /// - Returns: the int, or nil if it cannot be converted to a valid int
    func toInt() -> Int? {
        let allowedRange = Double(Int.min)..<Double(Int.max)
        if allowedRange.contains(self) {
            return Int(self)
        } else {
            return nil
        }
    }
}
