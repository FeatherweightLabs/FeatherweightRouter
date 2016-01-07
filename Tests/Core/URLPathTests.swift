//
//  URLPathTests.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import Beeline

class URLPathTests: XCTestCase {

    func testPathParsing() {
        let testPairs = [
            "": "",
            "/": "",
            "users": "users",
            "/users": "users",
            "users/": "users",
            "/users/": "users",
            "👍": "",
            "/👍/": "",
            "/users/id/": "users/id",
            "//example.com/users/": "users",
            "http://example.com/users/": "users",
            "users?": "users",
            "users?param1=value1": "users",
            "/users/?param1=value1": "users",
        ]
        for (src, result) in testPairs {
            XCTAssertEqual(URLPath(src).path, result)
        }
    }

    func testQueryParsing() {
        let testPairs = [
            "?": "",
            "?param1=value1": "param1=value1",
            "http://example.com/users/?param1=value1": "param1=value1",
        ]
        for (src, result) in testPairs {
            XCTAssertEqual(URLPath(src).query, result)
        }
    }

    func testEqatable() {
        let path = "TESTPATH"
        XCTAssertEqual(URLPath(path), URLPath(path))
    }

}
