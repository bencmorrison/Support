// Copyright © 2023 Ben Morrison. All rights reserved.

import SwiftUI
import RegexBuilder

extension Color {
    /// Allows the creation of a `Color` form Hexadecimal color.
    /// - Note: Expects `#` to be prepended to the string
    /// - Throws: an error when the format is not `#RRGGBB`
    /// - Parameter hexString: The Hexadecimal Color to use.
    init(hexString: String) throws {
        let hex = try HexColor(stringHexColor: hexString)
        self = hex.color
    }
    
    /// Allows the creation of a `Color` from a `UInt32` that represents
    /// a Hexadecimal color.
    /// - Throws: an error when the `hex` parameter is not equal to or below `0xFFFFFF`
    /// - Parameter hex: The Hexadecimal Color value to use.
    init(hex: UInt32) throws {
        let hex = try HexColor(hexValue: hex)
        self = hex.color
    }
    
    /// Allows the creation of a `Color` from the `HexColor` structure.
    /// - Parameter hexColor: The `HexColor` that defines your Hexadecimal color
    init(_ hexColor: HexColor) {
        self = hexColor.color
    }
    
    /// Allows the creation of a `Color` using the R, G, and B channels directly.
    /// While not requiring the user to devide by 1.0.
    /// - Parameters:
    ///   - red: The value for the red channel
    ///   - green: The value for the green channel
    ///   - blue: The value for the blue channel
    ///   - opacity: The opacity value.
    init(red: UInt8, green: UInt8, blue: UInt8, opacity: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            opacity: opacity
        )
    }
}

extension HexColor {
    /// Returns a new instance of a `Color` that is defined by the `HexColor` struture.
    var color: Color { Color(red: red, green: green, blue: blue) }
}
