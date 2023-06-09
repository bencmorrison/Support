// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

/// Defines the different types of Radixes supported in the custom `String` ininitaliser
/// that pretty prints the defined radix types in this enum
public enum Radix {
    case binary
    case octal
    case hexadecimal
    
    public var prefix: String {
        switch self {
        case .binary:
            return "0b"
        case .octal:
            return "0o"
        case .hexadecimal:
            return "0x"
        }
    }

    fileprivate var value: Int {
        switch self {
        case .binary:
            return 2
        case .octal:
            return 8
        case .hexadecimal:
            return 16
        }
    }
    
    fileprivate var byteMultiplier: Int {
        switch self {
        case .binary:
            return 8
        case .octal:
            return 3
        case .hexadecimal:
            return 2
        }
    }
}

/// Defines the prefixes to be used when formatting a `BinaryInteger` that uses the `Radix` type.
public enum FormattingPrefix {
    /// No prefix will be used
    case none
    /// Use the default prefix for the `Radix` in the formatting
    case `default`
    /// Use the provided custom prefix in the final product.
    case custom(String)
    
    public func getPrefix(for radix: Radix) -> String {
        switch self {
        case .none:
            return ""
        case .default:
            return radix.prefix
        case .custom(let custom):
            return custom
        }
    }
}

extension String {
    /// Creates a string from a `BinaryInteger` using the supplied formatting options.
    /// - Parameters:
    ///   - value: The `BinaryInteger` that you wish to have formatted
    ///   - radix: The `Radix` that the fomatting should use on the `value``
    ///   - uppercase: If the formatting will have letters, this will require them to be uppercase
    ///   - prefix: The `FormattingPrefix` to show in the string to denote the type of `Radix` used
    ///   - showLeadingZeros: When true, leading zeros are added for the zeroed out parts of the number.
    ///             Example: `UInt16` that equals 0x00FF will print out as 0x00FF instead of 0xFF
    public init<V: BinaryInteger>(_ value: V, radix: Radix, uppercase: Bool = true, prefix: FormattingPrefix = .default, showLeadingZeros: Bool = true) {
        let value = String(value, radix: radix.value, uppercase: uppercase)
        let prefix = prefix.getPrefix(for: radix)
        guard showLeadingZeros else { self = prefix + value; return }
        
        let digitCount = MemoryLayout<V>.size * radix.byteMultiplier
        let leadingZerosCount = digitCount - value.count
        let leadingZeros: String = (0..<leadingZerosCount).map({ _ in "0" }).joined()
        
        self = prefix + leadingZeros + value
    }
}
