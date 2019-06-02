//
//  StyledButton.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 02/06/2019.
//

import UIKit

/// A struct encapsulating the style of a button
public struct StyledButton {
    /// The shape of the button
    ///
    /// - round: a round button, i.e. width = height, corner radius = width / 2
    /// - square: a button with square corners
    /// - pill: a button with round ends, i.e. corner radius = height / 2
    public enum Shape {
        case circle
        case square
        case pill
        case rounded(cornerRadius: CGFloat)
    }

    fileprivate let shape: Shape
    fileprivate let borderWidth: CGFloat
    fileprivate let borderColour: UIColor
    fileprivate let backgroundColour: UIColor
    fileprivate let titleStyle: StyledFont
    fileprivate let hasShadow: Bool
    fileprivate let insets: UIEdgeInsets

    public init(shape: Shape,
                borderWidth: CGFloat,
                borderColour: UIColor,
                backgroundColour: UIColor,
                titleStyle: StyledFont,
                hasShadow: Bool,
                insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)) {
        self.shape = shape
        self.borderWidth = borderWidth
        self.borderColour = borderColour
        self.backgroundColour = backgroundColour
        self.titleStyle = titleStyle
        self.hasShadow = hasShadow
        self.insets = insets
    }
}

// MARK: - Apply the style to the button
public extension UIButton {
    /// Apply a styled button to a button
    ///
    /// - Parameter styledButton: the styled button to apply
    func apply(styledButton: StyledButton, title: String) {
        // Title style and colours
        contentEdgeInsets = styledButton.insets
        setStyledFontTitle(styledFont: styledButton.titleStyle, title: title, for: .normal)
        backgroundColor = styledButton.backgroundColour
        layer.borderWidth = styledButton.borderWidth
        layer.borderColor = styledButton.borderColour.cgColor
        updateShape(for: styledButton)

        // Add the shadow
        if styledButton.hasShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 0, height: 3)
            layer.shadowRadius = 2
        }
    }

    /// This must be called after the button has been laid out in the view
    ///
    /// - Parameter for: the styled button whose shape should be applied
    func updateShape(for styledButton: StyledButton) {
        switch styledButton.shape {
        case .circle:
            let smallestDimension = min(bounds.width, bounds.height)
            self.frame.size.width = smallestDimension
            self.frame.size.height = smallestDimension
            self.layer.cornerRadius = smallestDimension / 2
        case .square:
            // Nothing to do
            break
        case .pill:
            self.layer.cornerRadius = self.frame.height / 2
        case .rounded(let cornerRadius):
            self.layer.cornerRadius = cornerRadius
        }
    }
}
