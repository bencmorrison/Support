// Copyright © 2023 Ben Morrison. All rights reserved.

import SwiftUI

extension Color {
    /// Creates a color using the CMKY color space
    /// - Parameter cmyk: A `CMYKColor` defining the color
    public init(_ cmyk: CMYKColor) {
        self = cmyk.color
    }
    
    /// Creates a color using the CMKY color space
    /// - Note: If a channel value is over 100, it will be clamped to 100.
    /// - Parameters:
    ///   - cyan: The cyan channel value as a percent 0 to 100
    ///   - magenta: The magenta channel value as a percent 0 to 100
    ///   - yellow: The yellow channel value as a percent 0 to 100
    ///   - key: The key (black) channel value as a percent 0 to 100
    public init(cyan: UInt8, magenta: UInt8, yellow: UInt8, key: UInt8) {
        let rgb = CMYKColor.toRGB(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
        self.init(red: rgb.0, green: rgb.1, blue: rgb.2)
    }
    
    /// Creates  a color using the CMKY color space
    /// - Note: If a channel value is below 0.0 it is clammped to 0.0. If it is above 1.0, it is clampped to 1.0
    /// - Parameters:
    ///   - cyan: The cyan channel value as a decimal representation of a percentage.
    ///   - magenta: The magenta channel value a decimal representation of a percentage.
    ///   - yellow: The yellow channel value as a decimal representation of a percentage.
    ///   - key: The key (black) channel value as a decimal representation of a percentage.
    public init(cyan: Double, magenta: Double, yellow: Double, key: Double) {
        let rgb = CMYKColor.toRGB(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
        self.init(red: rgb.0, green: rgb.1, blue: rgb.2)
    }
}

extension CMYKColor {
    var color: Color {
        Color(red: rgbValues.0, green: rgbValues.1, blue: rgbValues.2)
    }
}
