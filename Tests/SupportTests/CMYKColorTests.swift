// Copyright © 2023 Ben Morrison. All rights reserved.

import XCTest
import SwiftUI

@testable import Support

final class CMYKColorTests: XCTestCase {
    func testCMYKtoRGB() throws {
        for color in TestColor.allCases {
            AssertCMYKtoRGBIsvaludForColor(color)
        }
    }
    
    func testRGBtoCMYK() throws {
        for color in TestColor.allCases {
            AssertRGBtoCMYKIsvaludForColor(color)
        }
    }
}

extension XCTest {
    fileprivate func AssertCMYKtoRGBIsvaludForColor(_ color: TestColor, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
        let rgbValue = CMYKColor.rgbValuesFrom(cyan: color.cmyk.0, magenta: color.cmyk.1, yellow: color.cmyk.2, key: color.cmyk.3)
        XCTAssertEqual(rgbValue.0, color.rgb.0, "Test color: \(color.rawValue.uppercased()) has Red Failure" + message())
        XCTAssertEqual(rgbValue.1, color.rgb.1, "Test color: \(color.rawValue.uppercased()) has Green Failure" + message())
        XCTAssertEqual(rgbValue.2, color.rgb.2, "Test color: \(color.rawValue.uppercased()) has Blue Failure" + message())
    }
    
    fileprivate func AssertRGBtoCMYKIsvaludForColor(_ color: TestColor, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
        let cmykValue = CMYKColor.cmykValuesFrom(red: color.rgb.0, green: color.rgb.1, blue: color.rgb.2)
        let cmyk = CMYKColor(cyan: cmykValue.0, magenta: cmykValue.1, yellow: cmykValue.2, key: cmykValue.3)
        let hex = cmyk.hexColor
        XCTAssertEqual(color.hex, hex.description, "Test color: \(color.rawValue.uppercased()) has a failure" + message())
    }
}

private extension CMYKColor {
    var hexColor: HexColor {
        HexColor(red: rgbValues.0, green: rgbValues.1, blue: rgbValues.2)
    }
}

