// Copyright © 2023 Ben Morrison. All rights reserved.

import RegexBuilder

extension RegexComponent where Self == String  {
    /// Defines the RegEx for a string to be a hexadecimal color.
    /// Expected represenation starting with a `#` followed by 6 hex digits.
    static var hexColor: Regex<Substring> { Regex.hexColor }
}

private extension Regex where Output == Substring {
    static var hexColor = Regex {
        Anchor.startOfLine
        "#"
        Repeat(count: 6) { .hexDigit }
        Anchor.endOfLine
    }
}
