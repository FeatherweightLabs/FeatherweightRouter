import XCTest
@testable import FeatherweightRouter

class StringRegexMatchTests: XCTestCase {

    func testSimpleMatchs() {
        XCTAssertTrue("MATCH".regexMatch("MATCH"))
        XCTAssertTrue("MATCH".regexMatch("yesMATCHyes"))
        XCTAssertTrue("^MATCH$".regexMatch("MATCH"))
    }

    func testSimpleFailures() {
        XCTAssertFalse("MATCH".regexMatch("match"))
        XCTAssertFalse("MATCH".regexMatch("NOPE"))
        XCTAssertFalse("^MATCH$".regexMatch("MATCHnope"))
    }
}
