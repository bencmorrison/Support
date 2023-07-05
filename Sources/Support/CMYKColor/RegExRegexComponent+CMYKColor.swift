// Copyright © 2023 Ben Morrison. All rights reserved.

import RegexBuilder

extension RegexComponent where Self == String  {
    /// Defines the RegEx for a string to be a cmyk color.
    /// Expected represenation starting with a `cmyk(` followed 4 percents and ends in `)`
    public static var cmykColor: Regex<Substring> { Regex.cmykColor }
}

private extension Regex where Output == Substring {
    static let cmykColor = Regex {
        Anchor.startOfLine
        "cmyk("
        Repeat(count: 3) {
            OneOrMore(.digit)
            "%,"
            ZeroOrMore { .whitespace }
        }
        ZeroOrMore { .whitespace }
        OneOrMore(.digit)
        "%)"
        Anchor.endOfLine
    }
}
