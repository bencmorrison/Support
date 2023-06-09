// Copyright © 2023 Ben Morrison. All rights reserved.

#if canImport(UIKit)

import UIKit
import SwiftUI

extension UIColor {
    /// A wrapper around the `init(dynamicProvider:)` function to make
    /// setting light and dark mode colors easier.
    ///
    /// - Note: Unknown modes are defaulted to `lightMode`
    /// - Parameters:
    ///   - lightMode: The color to use when the `userInterfaceStyle` is `light`  or unknown
    ///   - darkMode: The color to use when the `userInterfaceStyle` is `dark`
    public convenience init(lightMode: UIColor, darkMode: UIColor) {
        self.init { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? darkMode : lightMode
        }
    }
    
    /// A wrapper around the `init(dynamicProvider:)` function to make
    /// setting light and dark mode colors easier. While allowing us to use
    /// the `Color` struct for initalisation
    ///
    /// - Note: Unknown modes are defaulted to `lightMode`
    /// - Parameters:
    ///   - lightMode: The color to use when the `userInterfaceStyle` is `light` or unknown
    ///   - darkMode: The color to use when the `userInterfaceStyle` is `dark`
    public convenience init(lightMode: Color, darkMode: Color) {
        self.init(
            lightMode: UIColor(lightMode),
            darkMode: UIColor(darkMode)
        )
    }
}

#endif
