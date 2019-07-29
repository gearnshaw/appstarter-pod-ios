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
