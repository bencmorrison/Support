// Copyright © 2023 Ben Morrison. All rights reserved.

#if canImport(AppKit)

import AppKit
import SwiftUI

extension NSColor {
    /// A wrapper around the `init(name:, dynamicProvider:)` function to make
    /// setting light and dark mode colors easier.
    ///
    /// - Note: Unknown modes are defaulted to `lightMode`
    /// - Parameters:
    ///   - lightMode: The color to use when the `userInterfaceStyle` is `light`  or unknown
    ///   - darkMode: The color to use when the `userInterfaceStyle` is `dark`
    public convenience init(lightMode: NSColor, darkMode: NSColor) {
        self.init(name: nil) { appearance in
            switch appearance.name {
            case .aqua,
                    .vibrantLight,
                    .accessibilityHighContrastAqua,
                    .accessibilityHighContrastVibrantLight:
                return lightMode
            case .darkAqua,
                    .vibrantDark,
                    .accessibilityHighContrastDarkAqua,
                    .accessibilityHighContrastVibrantDark:
                return darkMode
            default: return lightMode
            }
        }
    }
    
    /// A wrapper around the `init(name:, dynamicProvider:)` function to make
    /// setting light and dark mode colors easier. While allowing us to use
    /// the `Color` struct for initalisation
    /// 
    /// - Note: Unknown modes are defaulted to `lightMode`
    /// - Parameters:
    ///   - lightMode: The color to use when the `userInterfaceStyle` is `light` or unknown
    ///   - darkMode: The color to use when the `userInterfaceStyle` is `dark`
    public convenience init(lightMode: Color, darkMode: Color) {
        self.init(
            lightMode: NSColor(lightMode),
            darkMode: NSColor(darkMode)
        )
    }
}

#endif
