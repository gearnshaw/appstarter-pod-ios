//
//  StyledFontBuilder.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 15/07/2019.
//

import Foundation

public extension StyledFont {
    // A builder that can be used to quickly and easily configure styled fonts
    public class Builder {
        // Defaults and configuration
        public static var defaultBaseColour = UIColor.black

        /// Use this function to set up any app-wide defaults that the builder should use
        ///
        /// - Parameter defaultBaseColour: the default base colour that styled font should adopt
        public static func configureDefaults(defaultBaseColour: UIColor) {
            self.defaultBaseColour = defaultBaseColour
        }

        private var size: Size = Sizes.body
        private var baseColour: UIColor = defaultBaseColour
        private var weight: Weight = .regular
        private var opacity: Opacity = Opacities.primary
        private var alignment: Alignment = .left
        private var customFontName: FontName? = nil

        /// Public initialiser
        public init() {}

        /// Build and return the configured styled font
        ///
        /// - Returns: The configured styled font
        public func build() -> StyledFont {
            return StyledFont(size: size,
                       baseColour: baseColour,
                       weight: weight,
                       opacity: opacity,
                       alignment: alignment,
                       customFontName: customFontName)
        }
    }

}

// MARK: - Functions for configuring the builder
public extension StyledFont.Builder {
    func with(size: StyledFont.Size) -> StyledFont.Builder {
        self.size = size
        return self
    }

    func with(baseColour: UIColor) -> StyledFont.Builder {
        self.baseColour = baseColour
        return self
    }

    func with(weight: StyledFont.Weight) -> StyledFont.Builder {
        self.weight = weight
        return self
    }

    func with(opacity: StyledFont.Opacity) -> StyledFont.Builder {
        self.opacity = opacity
        return self
    }

    func with(alignment: StyledFont.Alignment) -> StyledFont.Builder {
        self.alignment = alignment
        return self
    }

    func with(customFontName: StyledFont.FontName) -> StyledFont.Builder {
        self.customFontName = customFontName
        return self
    }
}
