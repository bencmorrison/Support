// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation
import PowerAssert


/// Provides a structure to define a Hexademimal color via it's R, G, and B channels
struct HexColor: CustomStringConvertible, CustomDebugStringConvertible {
    /// The value for the red channel
    let red: UInt8
    /// The value for the green channel
    let green: UInt8
    /// The value for the blue channel
    let blue: UInt8
    
    /// Allow the creation of a `HexColor` from a `String` representation of
    /// a Hexadecimal Color.
    /// - Note: This expects `#` to be pre-pended to the value.
    /// - Throws: an error when the format is not `#RRGGBB`
    /// - Parameter stringHexColor: The `String` representation of the hex color
    init(stringHexColor: String) throws {
        let values = try Self.rgbValues(from: stringHexColor)
        red = values.0
        green = values.1
        blue = values.2
    }
    
    /// Allow the creation of a `HexColor` from a `UInt32` representation of
    /// a Hexadecimal Color.
    /// - Throws: an error when the `hex` parameter is not equal to or below `0xFFFFFF`
    /// - Parameter hexValue: The `UInt32` representation of the hex color.
    init(hexValue: UInt32) throws {
        let values = try Self.rgbValues(from: UInt64(hexValue))
        red = values.0
        green = values.1
        blue = values.2
    }
    
    /// Takes a `String` representation of a Hexadecimal color and returns the
    /// three color channels for that represenation.
    /// - Throws: an error when the format is not `#RRGGBB`
    /// - Parameter stringHexColor: The `String` represenation of the hexadecimal color
    /// - Returns: A Tupal of the Red, Green, and Blue channel values, in that order.
    static func rgbValues(from stringHexColor: String) throws -> (UInt8, UInt8, UInt8) {
        #assert(stringHexColor.contains(.hexColor), "Expected Format: #RRGGBB")
        
        let hexColorString = String(stringHexColor.dropFirst())
        let scanner = Scanner(string: hexColorString)
        var hex: UInt64 = 0
        scanner.scanHexInt64(&hex)
        
        return try rgbValues(from: hex)
    }
    
    /// Takes a `UInt64` representation of a Hexadecimal color and returns the
    /// three color channels for that represenation.
    /// - Throws: an error when the `hex` parameter is not equal to or below `0xFFFFFF`
    /// - Parameter stringHexColor: The `UInt64` represenation of the hex color
    /// - Returns: A Tupal of the Red, Green, and Blue channel values, in that order.
    static func rgbValues(from hexValue: UInt64) throws -> (UInt8, UInt8, UInt8) {
        #assert(hexValue < 0xFFFFFF, "hexValue should be <= 0xFFFFFF")
        
        let red = UInt8((0xFF0000 & hexValue) >> 16)
        let green = UInt8((0x00FF00 & hexValue) >> 8)
        let blue = UInt8(0x0000FF & hexValue)
        
        return(red, green, blue)
    }
    
    // MARK: - CustomStringConvertible, CustomDebugStringConvertible
    private var combinedValue: UInt32 { UInt32(self) }
    var description: String {
        String(combinedValue, radix: .hexadecimal, prefix: .custom("#"))
    }
    
    var debugDescription: String {
        return """
        red: \(String(red, radix: .hexadecimal, showLeadingZeros: false)), green: \(String(green, radix: .hexadecimal, showLeadingZeros: false)), blue: \(String(blue, radix: .hexadecimal, showLeadingZeros: false)))
        combined: \(description))
        """
    }
}
