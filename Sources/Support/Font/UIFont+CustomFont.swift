// Copyright © 2023 Ben Morrison. All rights reserved.

#if canImport(UIKit)

import UIKit

extension UIFont {
    static func customFont(_ font: UIFont, forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
}

#endif
