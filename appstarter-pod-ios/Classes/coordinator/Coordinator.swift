//
//  Coordinator.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 27/07/2019.
//

import Foundation

/// A protocol that represents a coordinator, to allow us to control screen
/// flow throughout an app
public protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

/// An extension of Coordinator to use on coordinators that will be used on tab bars.
/// To use, ensure that the tab index of the coordinator is set **before** callingn `start()`
/// The start function should create a `UITabBarItem` from the root view controller in the coordinator.
public protocol TabbableCoordinator: Coordinator {
    var tabIndex: Int { get set }
}
