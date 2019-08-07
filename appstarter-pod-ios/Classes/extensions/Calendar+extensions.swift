//
//  Calendar+extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 07/08/2019.
//

import Foundation

// TODO: Unit test
public extension Calendar {
    /// Takes an array of components with a date, and returns a unique list of
    /// days covered by the components.
    /// NB the return value contains the time for the start of the day, which is dependent
    /// on the calendar (and specifically the timezone of the calendar)
    ///
    /// - Parameter dateables: a list of components with dates
    /// - Returns: A list of unique dates covered by the components, sorted in ascending date order
    func getUniqueDays(dateds: [Dated]) -> [Date] {
        let startOfDays = dateds.map {
            startOfDay(for: $0.date)
        }
        let uniques = Set(startOfDays)
        return Array(uniques)
            .sorted()
    }
}
