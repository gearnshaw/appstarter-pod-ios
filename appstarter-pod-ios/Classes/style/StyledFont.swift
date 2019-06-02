//
//  StyledFont.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 02/06/2019.
//

import Foundation
import UIKit

/// A struct to encapsulate text styles in Sketch
public struct StyledFont {
    public typealias Size = CGFloat
    public struct Sizes {
        public static let small: Size = 10
        public static let caption: Size = 12
        public static let subheader: Size = 16
        public static let body: Size = 20
        public static let title: Size = 30
        public static let headline: Size = 24
        public static let display: Size = 32
    }

    /// Constants for the names of commonly used fonts.
    /// NB in order to use custom fonts, they must first be installed
    /// in the project: https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app
    public struct CustomFontNames {
        public static let fontLight = "FontAwesome5Pro-Light"
        public static let fontRegular =  "FontAwesome5Pro-Regular"
        public static let fontSolid = "FontAwesome5Pro-Solid"
    }

    public struct Opacities {
        public static let primary: CGFloat = 0.99
        public static let secondary: CGFloat = 0.7
        public static let disabled: CGFloat = 0.5
    }

    public enum Alignment {
        case left
        case centre
        case right
        case justified
    }

    public enum Weight {
        case light
        case regular
        case heavy
    }

    // State
    private let size: Size
    fileprivate let baseColour: UIColor
    private let weight: Weight
    private let opacity: CGFloat
    fileprivate let alignment: Alignment
    private let customFontName: String?

    public init(size: Size, baseColour: UIColor, weight: Weight, opacity: CGFloat, alignment: Alignment, customFontName: String? = nil) {
        self.size = size
        self.baseColour = baseColour
        self.weight = weight
        self.opacity = opacity
        self.alignment = alignment
        self.customFontName = customFontName
    }

    /// Get the font object that should be used for this styled font
    ///
    /// - Returns: a UIFont, based on the style and whether or not the type should be emphasised
    public var font: UIFont {
        if let customFontName = customFontName {
            return getCustomFont(for: customFontName)
        } else {
            return getStandardFont()
        }
    }

    /// Get the colour that should be used, taking into account both the colour and the opacity
    var colour: UIColor {
        return baseColour.withAlphaComponent(opacity)
    }

    /// Gets attributes for the styled font
    ///
    /// - Returns: the font and colour attributes
    var attributes: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: colour]
    }

    /// Get an attributed string based on the styled font
    ///
    /// - Parameter string: the string
    /// - Returns: an attributed string
    func attributedString(string: String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: attributes)
    }
}

private extension StyledFont {
    /// Get the standard system font
    ///
    /// - Returns: the standard system font for the given settings
    func getStandardFont() -> UIFont {
        let systemWeight: UIFont.Weight
        switch weight {
        case .light:
            systemWeight = .light
        case .regular:
            systemWeight = .regular
        case .heavy:
            systemWeight = .heavy
        }
        return UIFont.systemFont(ofSize: size, weight: systemWeight)
    }

    /// Return a custom font
    ///
    /// - Parameter name: the name of the font (i.e. the name used to load the font, not the description)
    /// - Returns: An instance of the font, or the standard font if a font couldn't be loaded for the name
    func getCustomFont(for name: String) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return getStandardFont()
        }
        return font
    }
}

public extension UIButton {
    func setStyledFontTitle(styledFont: StyledFont, title: String, for controlState: UIControl.State) {
        setAttributedTitle(styledFont.attributedString(string: title), for: controlState)
    }
}

// MARK: - Styled font helpers for UILabel
public extension UILabel {
    func setStyledFont(styledFont: StyledFont) {
        font = styledFont.font
        textColor = styledFont.colour

        let textAlignment: NSTextAlignment
        switch styledFont.alignment {
        case .centre:
            textAlignment = .center
        case .left:
            textAlignment = .left
        case.right:
            textAlignment = .right
        case.justified:
            textAlignment = .justified
        }
        self.textAlignment = textAlignment
    }
}

// MARK: - Styled font helpers for UITextView
public extension UITextView {
    func setStyledFont(styledFont: StyledFont) {
        font = styledFont.font
        textColor = styledFont.colour

        let textAlignment: NSTextAlignment
        switch styledFont.alignment {
        case .centre:
            textAlignment = .center
        case .left:
            textAlignment = .left
        case.right:
            textAlignment = .right
        case .justified:
            textAlignment = .justified
        }
        self.textAlignment = textAlignment
    }
}

// MARK: - Styled font helpers for UIBarButtonItem
public extension UIBarButtonItem {
    func setStyledFont(styledFont: StyledFont, for controlState: UIControl.State) {
        self.setTitleTextAttributes(styledFont.attributes, for: controlState)
    }
}

public extension CATextLayer {
    func setStyledFont(styledFont: StyledFont) {
        font = CGFont(styledFont.font.fontName as CFString)
        fontSize = styledFont.font.pointSize
        foregroundColor = styledFont.colour.cgColor

        let alignmentMode: String
        switch styledFont.alignment {
        case .centre:
            alignmentMode = CATextLayerAlignmentMode.center.rawValue
        case .left:
            alignmentMode = CATextLayerAlignmentMode.left.rawValue
        case.right:
            alignmentMode = CATextLayerAlignmentMode.right.rawValue
        case .justified:
            alignmentMode = CATextLayerAlignmentMode.justified.rawValue
        }
        self.alignmentMode = CATextLayerAlignmentMode(rawValue: alignmentMode)
    }
}
