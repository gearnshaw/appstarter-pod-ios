//
//  StyledButtonBuilder.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 28/07/2019.
//

import Foundation

public extension StyledButton {
    // A builder that can be used to quickly and easily configure styled buttons
    class Builder {
        private var shape = StyledButton.Shape.pill
        private var borderWidth: CGFloat = 0
        private var borderColour = UIColor.black
        private var backgroundColour = UIColor.clear
        private var titleStyle = StyledFont.Builder().build()
        private var hasShadow = false
        private var insets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        // Public initialiser
        public init() {}

        public func build() -> StyledButton {
            return StyledButton(shape: shape,
                                borderWidth: borderWidth,
                                borderColour: borderColour,
                                backgroundColour: backgroundColour,
                                titleStyle: titleStyle,
                                hasShadow: hasShadow,
                                insets: insets)
        }
    }
}

// MARK: - Functions for configuring the builder
public extension StyledButton.Builder {
    func with(shape: StyledButton.Shape) -> StyledButton.Builder {
        self.shape = shape
        return self
    }

    func with(borderWidth: CGFloat) -> StyledButton.Builder {
        self.borderWidth = borderWidth
        return self
    }

    func with(borderColour: UIColor) -> StyledButton.Builder {
        self.borderColour = borderColour
        return self
    }

    func with(backgroundColour: UIColor) -> StyledButton.Builder {
        self.backgroundColour = backgroundColour
        return self
    }

    func with(titleStyle: StyledFont) -> StyledButton.Builder {
        self.titleStyle = titleStyle
        return self
    }

    func with(hasShadow: Bool) -> StyledButton.Builder {
        self.hasShadow = hasShadow
        return self
    }

    func with(insets: UIEdgeInsets) -> StyledButton.Builder {
        self.insets = insets
        return self
    }
}
