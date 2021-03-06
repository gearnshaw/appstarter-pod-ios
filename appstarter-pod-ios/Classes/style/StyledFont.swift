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

    /// Constants for the names of commonly used fonts.
    /// NB in order to use custom fonts, they must first be installed
    /// in the project: https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app
    public typealias CustomFontName = String
    public typealias Opacity = CGFloat

    /// Enum representing text alignment of the font style
    public enum Alignment {
        case left
        case centre
        case right
        case justified

        /// Convert alignment to a CATextLayerAlignmentMode
        var alignmentMode: CATextLayerAlignmentMode {
            let alignmentMode: CATextLayerAlignmentMode
            switch self {
            case .centre:
                alignmentMode = .center
            case .left:
                alignmentMode = .left
            case.right:
                alignmentMode = .right
            case .justified:
                alignmentMode = .justified
            }
            return alignmentMode
        }

        /// Convert alignment to a text alignment
        var textAlignment: NSTextAlignment {
            let textAlignment: NSTextAlignment
            switch self {
            case .centre:
                textAlignment = .center
            case .left:
                textAlignment = .left
            case.right:
                textAlignment = .right
            case .justified:
                textAlignment = .justified
            }
            return textAlignment
        }
    }

    /// Enum representing the weight of a font style
    public enum Weight {
        case light
        case regular
        case heavy

        /// Convert font weight into a UIFont weight
        var fontWeight: UIFont.Weight {
            let fontWeight: UIFont.Weight
            switch self {
            case .light:
                fontWeight = .light
            case .regular:
                fontWeight = .regular
            case .heavy:
                fontWeight = .heavy
            }
            return fontWeight
        }
    }

    // State
    private let size: Size
    fileprivate let baseColour: UIColor
    private let weight: Weight
    private let opacity: Opacity
    fileprivate let alignment: Alignment
    private let customFontName: CustomFontName?

    public init(size: Size, baseColour: UIColor, weight: Weight, opacity: Opacity, alignment: Alignment, customFontName: CustomFontName? = nil) {
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

// MARK: - Create images from style text
public extension StyledFont {
    /// Generates an image representation of a string in a given style
    ///
    /// - Parameter string: the string
    /// - Returns: an image of the string in a given style
    func createImageFor(string: String) -> UIImage? {
        let symbol = attributedString(string: string)
        let mutableSymbol = NSMutableAttributedString(attributedString: symbol)
        let symbolSize = mutableSymbol.size()
        let rect = CGRect(x: 0, y: 0, width: symbolSize.width, height: symbolSize.height)

        let paragraphStyle = NSMutableParagraphStyle()
        let textStyle: NSTextAlignment
        switch alignment {
        case .left:
            textStyle = .left
        case .centre:
            textStyle = .center
        case .right:
            textStyle = .right
        case .justified:
            textStyle = .justified
        }
        paragraphStyle.alignment = textStyle

        mutableSymbol.addAttribute(NSAttributedString.Key.paragraphStyle,
                                   value: paragraphStyle,
                                   range: NSRange(location: 0, length: mutableSymbol.length))

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        mutableSymbol.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}

// MARK: - Private helper functions
private extension StyledFont {
    /// Get the standard system font
    ///
    /// - Returns: the standard system font for the given settings
    func getStandardFont() -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight.fontWeight)
    }

    /// Return a custom font
    ///
    /// - Parameter name: the name of the font (i.e. the name used to load the font, not the description)
    /// - Returns: An instance of the font, or the standard font if a font couldn't be loaded for the name
    func getCustomFont(for name: CustomFontName) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return getStandardFont()
        }
        return font
    }
}

// MARK: - Styled font helpers for UIButton
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
        textAlignment = styledFont.alignment.textAlignment
    }
}

// MARK: - Styled font helpers for UITextView
public extension UITextView {
    func setStyledFont(styledFont: StyledFont) {
        font = styledFont.font
        textColor = styledFont.colour
        textAlignment = styledFont.alignment.textAlignment
    }
}

// MARK: - Styled font helpers for UIBarButtonItem
public extension UIBarButtonItem {
    func setStyledFont(styledFont: StyledFont, for controlState: UIControl.State) {
        self.setTitleTextAttributes(styledFont.attributes, for: controlState)
    }
}

// MARK: - Styled font helpers for CATextLayer
public extension CATextLayer {
    func setStyledFont(styledFont: StyledFont) {
        font = CGFont(styledFont.font.fontName as CFString)
        fontSize = styledFont.font.pointSize
        foregroundColor = styledFont.colour.cgColor
        alignmentMode = styledFont.alignment.alignmentMode
    }
}

// MARK: - Standard values of size
public extension StyledFont.Size {
    static let small: StyledFont.Size = 10
    static let caption: StyledFont.Size = 12
    static let subheader: StyledFont.Size = 16
    static let body: StyledFont.Size = 20
    static let title: StyledFont.Size = 30
    static let headline: StyledFont.Size = 24
    static let display: StyledFont.Size = 32
}

// MARK: - Standard custom font names
public extension StyledFont.CustomFontName {
    static let iconLight: StyledFont.CustomFontName = "FontAwesome5Pro-Light"
    static let iconRegular: StyledFont.CustomFontName =  "FontAwesome5Pro-Regular"
    static let iconSolid: StyledFont.CustomFontName = "FontAwesome5Pro-Solid"
}

// MARK: - Standard opacities
public extension StyledFont.Opacity {
    static let primary: StyledFont.Opacity = 0.9
    static let secondary: StyledFont.Opacity = 0.7
    static let disabled: StyledFont.Opacity = 0.5
}
