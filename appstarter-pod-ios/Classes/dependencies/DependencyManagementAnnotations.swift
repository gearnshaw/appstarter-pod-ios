//
//  DependencyManagementAnnotations.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 08/07/2019.
//

import Foundation

/// An empty protocol to signal that a type should be added to the dependency manager as a singleton style dependency
protocol SingletonDependency {}

/// An empty protocol to signal that a type should be added to the dependency manager as a factoried dependency
protocol FactoriedDependency {}
