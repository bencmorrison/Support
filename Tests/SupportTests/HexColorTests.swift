import XCTest
@testable import Support

final class HexColorTests: XCTestCase {
    func testRGBToHexColor() throws {
        for color in TestColor.allCases {
            let rgb = color.rgb
            let hexColor = HexColor(red: rgb.0, green: rgb.1, blue: rgb.2)
            
            XCTAssertEqual(color.hex, hexColor.description, "Color: \(color.rawValue.uppercased())")
        }
    }
    
    func testHexStringToHexColor() throws {
        for color in TestColor.allCases {
            let hexColor = try HexColor(stringHexColor: color.hex)
            
            XCTAssertEqual(color.hex, hexColor.description, "Color: \(color.rawValue.uppercased())")
        }
    }
    
    func testHexIntToHexColor() throws {
        for color in TestColor.allCases {
            let hexColor = try HexColor(hexValue: color.hexInt)
            
            XCTAssertEqual(color.hex, hexColor.description, "Color: \(color.rawValue.uppercased())")
        }
    }
}
