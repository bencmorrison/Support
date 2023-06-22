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
        self.rgbValues = Self.toRGB(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
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
        let rgb = Self.toRGB(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
        self.rgbValues = (rgb.0.percentAsUInt8, rgb.1.percentAsUInt8, rgb.2.percentAsUInt8)
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

