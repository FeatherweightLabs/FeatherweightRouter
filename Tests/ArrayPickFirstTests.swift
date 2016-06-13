import XCTest
@testable import FeatherweightRouter

class ArrayPickFirstTests: XCTestCase {

    let sourceArray = [1, 2, 3, 4, 5, 6]

    func testPicksFirst() {
        let expected = 3
        let actual = sourceArray.pickFirst() { $0 > 2 ? $0 : nil }

        XCTAssertEqual(expected, actual)
    }

    func testPicksNil() {
        XCTAssertNil([Int]().pickFirst { $0 })
        XCTAssertNil([0].pickFirst { $0 == 0 ? nil : nil })
    }
}
