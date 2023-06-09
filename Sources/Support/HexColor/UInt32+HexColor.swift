// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension UInt32 {
    /// Allows an UInt32 to be quickly created from a `HexColor`
    /// The value can be used as a normal `UInt32`. Primarly being used to
    /// display the value in strings.
    /// - Parameter hexColor: The `HexColor` that needs to be converted
    ///             to an `UInt32`
    public init(_ hexColor: HexColor) {
        self = ((UInt32(hexColor.red) << 16) | (UInt32(hexColor.green) << 8) | UInt32(hexColor.blue))
    }
}
