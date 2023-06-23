// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

/// Provides a structure that defines CMYK values for color use.
public struct CMYKColor: Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    /// The cyan channel value represented as a percentage.
    public let cyan: UInt8
    /// The magenta channel value represented as a percentage.
    public let magenta: UInt8
    /// The yellow channel value represented as a percentage.
    public let yellow: UInt8
    /// The key (black) channel value represented as a percentage.
    public let key: UInt8
    /// A Tupal of the RGB represenation ordered respectively.
    public let rgbValues: (UInt8, UInt8, UInt8)
    
    /// Creates a `CMYKColor` frome the provided channels in percentage form.
    /// - Note: If a channel value is over 100, it will be clamped to 100.
    /// - Parameters:
    ///   - cyan: The cyan channel value as a percent 0 to 100
    ///   - magenta: The magenta channel value as a percent 0 to 100
    ///   - yellow: The yellow channel value as a percent 0 to 100
    ///   - key: The key (black) channel value as a percent 0 to 100
    public init(cyan: UInt8, magenta: UInt8, yellow: UInt8, key: UInt8) {
        self.cyan = cyan.percent
        self.magenta = magenta.percent
        self.yellow = yellow.percent
        self.key = key.percent
        self.rgbValues = Self.rgbValuesFrom(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
    }
    
    /// Creates a `CMYKColor` frome the provided channels in a decimal representation of a percentage.
    /// - Note: If a channel value is below 0.0 it is clammped to 0.0. If it is above 1.0, it is clampped to 1.0
    /// - Parameters:
    ///   - cyan: The cyan channel value as a decimal representation of a percentage.
    ///   - magenta: The magenta channel value a decimal representation of a percentage.
    ///   - yellow: The yellow channel value as a decimal representation of a percentage.
    ///   - key: The key (black) channel value as a decimal representation of a percentage.
    public init(cyan: Double, magenta: Double, yellow: Double, key: Double) {
        self.cyan = cyan.percentAsUInt8
        self.magenta = magenta.percentAsUInt8
        self.yellow = yellow.percentAsUInt8
        self.key = key.percentAsUInt8
        let rgb = Self.rgbValuesFrom(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
        self.rgbValues = (rgb.0.percentAsUInt8, rgb.1.percentAsUInt8, rgb.2.percentAsUInt8)
    }
    
    /// Converts CMYK values to RGB
    /// - Note: If a channel value is above 100, it will be clamped to 100
    /// - Parameters:
    ///   - cyan: The cyan channel value as a percent 0 to 100
    ///   - magenta: The magenta channel value as a percent 0 to 100
    ///   - yellow: The yellow channel value as a percent 0 to 100
    ///   - key: The key (black) channel value as a percent 0 to 100
    /// - Returns: A tupal of the RGB values, in that order. The values will be 0 to 255.
    public static func rgbValuesFrom(cyan: UInt8, magenta: UInt8, yellow: UInt8, key: UInt8) -> (UInt8, UInt8, UInt8) {
        let adjustedKey = UInt(100 - key)
        
        let red   = UInt(255 * (100 - UInt(cyan)) * adjustedKey)
        let green = UInt(255 * (100 - UInt(magenta)) * adjustedKey)
        let blue  = UInt(255 * (100 - UInt(yellow)) * adjustedKey)
        
        return (
            UInt8(ceil(Double(red) / Double(10000))),
            UInt8(ceil(Double(green) / Double(10000))),
            UInt8(ceil(Double(blue) / Double(10000)))
        )
    }
    
    /// Converts CMYK values to RGB
    /// - Note: If a channel value is below 0.0 it is clammped to 0.0. If it is above 1.0, it is clampped to 1.0
    /// - Parameters:
    ///   - cyan: They cyan channel value as a decimal representation of a percentage.
    ///   - magenta: The magenta channel value as a decimal representation of a percentage.
    ///   - yellow: The yellow channel value as a decimal representation of a percentage.
    ///   - key: The key (black) channel value as a decimal representation of a percentage.
    /// - Returns: A tupal of the RGB values, in that order. The values are a decimal representation of a percentage.
    public static func rgbValuesFrom(cyan: Double, magenta: Double, yellow: Double, key: Double) -> (Double, Double, Double) {
        let values = self.rgbValuesFrom(
            cyan: cyan.percentAsUInt8,
            magenta: magenta.percentAsUInt8,
            yellow: yellow.percentAsUInt8,
            key: key.percentAsUInt8
        )
        
        return (values.0.percentDouble, values.1.percentDouble, values.2.percentDouble)
    }
    
    /// Converts RGB values to CMYK
    /// - Note: Channel values should be from 0 - 255, and will be clamped is above 255.
    /// - Parameters:
    ///   - red: The red channel represenation
    ///   - green: The green channel represenation
    ///   - blue: The blue channel represenation
    /// - Returns: A tupal of CMYK values, in that order. Values are represented as a percentage (0 - 100)
    public static func cmykValuesFrom(red: UInt8, green: UInt8, blue: UInt8) -> (UInt8, UInt8, UInt8, UInt8) {
        let redPrime = UInt(floor(Double(UInt(red) * 100) / 255.0))
        let greenPrime = UInt(floor(Double(UInt(green) * 100) / 255.0))
        let bluePrime = UInt(floor(Double(UInt(blue) * 100) / 255.0))
        let key = 100 - max(redPrime, greenPrime, bluePrime)
        
        var adjustedKey = 100 - key
        if adjustedKey == 0 { adjustedKey = 1 }
        
        let cyan = Double(100 - redPrime - key) / Double(adjustedKey)
        let magenta = Double(100 - greenPrime - key) / Double(adjustedKey)
        let yellow = Double(100 - bluePrime - key) / Double(adjustedKey)
        
        return (
            UInt8(ceil(cyan * 100)),
            UInt8(ceil(magenta * 100)),
            UInt8(ceil(yellow * 100)),
            UInt8(key)
        )
    }
    
    /// Converts RGB values to CMYK
    /// - Note: Channel values should be from 0.0 - 1.0. Values below 0.0 will be clamped to 0.0, and above 1.0 will
    ///         be clamped to 1.0.
    /// - Parameters:
    ///   - red: The red channel represenation as a decimal representation of a percentage.
    ///   - green: The green channel represenation as a decimal representation of a percentage.
    ///   - blue: The blue channel represenation as a decimal representation of a percentage.
    /// - Returns: A tupal of CMYK values, in that order. Values are represented as a decimal representation of a percentage.
    public static func cmykValuesFrom(red: Double, green: Double, blue: Double) -> (Double, Double, Double, Double) {
        let values = cmykValuesFrom(
            red: red.percentAsUInt8,
            green: green.percentAsUInt8,
            blue: blue.percentAsUInt8
        )
        
        return (
            values.0.percentDouble,
            values.1.percentDouble,
            values.2.percentDouble,
            values.3.percentDouble
        )
    }
    
    // MARK: Equatable
    
    public static func == (lhs: CMYKColor, rhs: CMYKColor) -> Bool {
        return lhs.cyan == rhs.cyan &&
        lhs.magenta == rhs.magenta &&
        lhs.yellow == rhs.yellow &&
        lhs.key == rhs.key
    }
    
    // MARK: CustomStringConvertible, CustomDebugStringConvertible
    
    public var description: String {
        "(\(cyan), \(magenta), \(yellow), \(key))"
    }
    
    public var debugDescription: String {
        """
           cyan: \(cyan)
        magenta: \(magenta)
         yellow: \(yellow)
            key: \(key)
        """
    }
}


private extension Double {
    /// Clamps the value between 0.0 and 1.0
    var percent: Double {
        if self < 0.0 { return 0.0 }
        if self > 1.0 { return 1.0 }
        return self
    }
    /// Clamps the value between 0.0 and 1.0, and then multiples by 100.0
    var percentAsUInt8: UInt8 {
        return UInt8(self.percent * 100.0)
    }
}

private extension UInt8 {
    /// Clamps the value to be between 0 and 100
    var percent: Self {
        (self > 100) ? 100 : self
    }
    
    /// Clamps the value to be between 0 and 100, and then divides by 100.0
    var percentDouble: Double {
        Double(self.percent) / 100.0
    }
}
