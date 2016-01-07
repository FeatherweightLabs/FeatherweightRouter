//
//  RegexUnit.swift
//  Beeline
//
//  Created by Karl Bowden on 5/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import Beeline

class RegexUnit: XCTestCase {

    func testMatches() {
        let regex = Regex(pattern: "^something$")
        XCTAssertEqual(regex.matches("something").count, 1)
        XCTAssertEqual(regex.matches("SOMETHING").count, 0)
        XCTAssertEqual(regex.matches("somethin-").count, 0)
        XCTAssertEqual(regex.matches("-omething").count, 0)

        XCTAssertEqual(Regex(pattern: "^some").matches("something").count, 1)
        XCTAssertEqual(Regex(pattern: "thing$").matches("something").count, 1)
        XCTAssertEqual(Regex(pattern: "et").matches("something").count, 1)
    }

    func testMatchesEmoji() {
        let regex = Regex(pattern: "^sun😎glasses$")
        XCTAssertEqual(regex.matches("sun😎glasses").count, 1)
        XCTAssertEqual(regex.matches("sun💀glasses").count, 0)
    }

    func testMatch() {
        let regex = Regex(pattern: "^something$")
        XCTAssertEqual(regex.match("something")!, "something")
        XCTAssertNil(regex.match("SOMETHING"))
        XCTAssertNil(regex.match("somethin-"))
        XCTAssertNil(regex.match("-omething"))
        XCTAssertEqual(Regex(pattern: "^MOCK").match("MOCKSTRING")!, "MOCK")
    }

    func testMatchEmoji() {
        XCTAssertEqual(Regex(pattern: "^sun😎glasses$").match("sun😎glasses"), "sun😎glasses")
    }

    func testReplace() {
        let regex = Regex(pattern: "^/{0,1}somepath/{0,1}")
        let remainder = regex.replace("somepath/remainder") ?? ""

        XCTAssertEqual(remainder, "remainder")
        XCTAssertEqual(regex.replace("/somepath/") ?? "NOPE", "")
    }

    func testReplaceEmoji() {
        XCTAssertEqual(Regex(pattern: "😎").replace("😎"), "")
        XCTAssertEqual(Regex(pattern: "^sun😎").replace("sun😎glasses"), "glasses")
        XCTAssertEqual(Regex(pattern: "😎glasses").replace("sun😎glasses"), "sun")
        XCTAssertEqual(Regex(pattern: "^sun").replace("sun😎glasses"), "😎glasses")
    }
}
