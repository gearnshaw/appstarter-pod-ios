//
//  UIViewController+extensions.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 16/08/2019.
//

import Foundation
import UIKit

// MARK: - Extensions on view controller
public extension UIViewController {
    /// Add functionality to a view controller to hide the keyboard when the user taps outside of it
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Used by the `hideKeyboardWhenTappedAround` function
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
