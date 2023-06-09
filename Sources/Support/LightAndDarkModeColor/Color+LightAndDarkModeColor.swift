// Copyright © 2023 Ben Morrison. All rights reserved.

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


extension Color {
    /// Creates color that responds to light or dark mode for device
    /// 
    /// - Note: Unknown modes are defaulted to `lightMode`
    /// - Parameters:
    ///   - lightMode: The color to use when the `userInterfaceStyle` is `light`  or unknown
    ///   - darkMode: The color to use when the `userInterfaceStyle` is `dark`
    init(lightMode: Color, darkMode: Color) {
        #if canImport(AppKit)
        self.init(NSColor(lightMode: lightMode, darkMode: darkMode))
        #else
        self.init(uiColor: UIColor(lightMode: lightMode, darkMode: darkMode))
        #endif
    }
}

