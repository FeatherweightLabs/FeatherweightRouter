//
//  PathUnit.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import Beeline

class PathUnit: XCTestCase {


    // MARK: - Mocks

    struct TestPath: Path {
        let path: String
        let query: String
        let pattern: String

        init(_ raw: String) {
            path = raw
            query = raw
            pattern = raw
        }

        init(_ path: String, _ query: String, _ pattern: String) {
            self.path = path
            self.query = query
            self.pattern = pattern
        }

        func mutate(path path: String?, query: String?, pattern: String?) -> Path {
            return TestPath(path ?? self.path, query ?? self.path, pattern ?? self.path)
        }
    }

    // MARK: - Dummys

    let mockString = "MOCK/STRING"
    let replacement = "REPLACEMENT"
    let path: Path = TestPath("MOCK/STRING")

    // MARK: - Tests

    // MARK: mutate

    func testMutatePath() {
        let mutated = path.mutate(path: replacement, query: nil, pattern: nil)
        let expected = TestPath(replacement, mockString, mockString)
        XCTAssert(mutated === expected)
    }

    func testMutateQuery() {
        let mutated = path.mutate(path: nil, query: replacement, pattern: nil)
        let expected = TestPath(mockString, replacement, mockString)
        XCTAssert(mutated === expected)
    }

    func testMutatePattern() {
        let mutated = path.mutate(path: nil, query: nil, pattern: replacement)
        let expected = TestPath(mockString, mockString, replacement)
        XCTAssert(mutated === expected)
    }

    // MARK: matchesPattern

    func testMatchesPatternSuccessOnPathComponentBoundaries() {
        XCTAssert(path.matchesPattern(mockString))
        XCTAssert(path.matchesPattern("MOCK"))
    }

    func testMatchesEmojiSucceeds() {
        XCTAssertTrue(TestPath("😎").matchesPattern("😎"))
        XCTAssertTrue(TestPath("😎").matchesPattern("^😎"))
        XCTAssertTrue(TestPath("😎").matchesPattern("^😎$"))
        XCTAssertTrue(TestPath("😎").matchesPattern("^😎(/|$)"))
        XCTAssertTrue(TestPath("😎/").matchesPattern("^😎(/|$)"))
        XCTAssertTrue(TestPath("sun😎glasses").matchesPattern("sun😎glasses"))
    }

    func testMatchesPatternOnlyFromStart() {
        XCTAssert(path.matchesPattern("MOCK"))
        XCTAssertFalse(path.matchesPattern("OCK"))
        XCTAssertFalse(path.matchesPattern("STRING"))
    }

    func testMatchesPatternIsCaseSensitive() {
        XCTAssert(path.matchesPattern(mockString))
        XCTAssertFalse(path.matchesPattern(mockString.lowercaseString))
    }

    func testMatchesPatternFailure() {
        XCTAssertFalse(path.matchesPattern("MOCK/"))
        XCTAssertFalse(path.matchesPattern("^MOCK/STRIN"))
        XCTAssertFalse(path.matchesPattern("MOCK/STRIN"))
        XCTAssertFalse(path.matchesPattern("OCK/STRING"))
        XCTAssertFalse(path.matchesPattern("OCK/STRING$"))
        XCTAssertFalse(path.matchesPattern("^OCK/STRING$"))
        XCTAssertFalse(path.matchesPattern("^MOCK/STRIN$"))
    }

    // MARK: splitBy

    func testSplitByPatternSuccess() {
        let split = path.splitBy("MOCK")
        XCTAssertNotNil(split)
        if let (match, remainder) = split {
            XCTAssert(match == "MOCK")
            XCTAssert(remainder == "STRING")
        }
    }

    func testSplitByPatternFailure() {
        XCTAssertNil(path.splitBy("MOC"))
        XCTAssertNil(path.splitBy("OCK"))
    }

    // MARK: ==<Path, TestPath>

    func testEquatable() {
        let testPath = TestPath(mockString)
        let pathPath: Path = testPath
        XCTAssert(path == testPath)
        XCTAssert(path == pathPath)
    }

    // MARK: ===<Path, Path>

    func testExactEquatable() {
        let expectedTestPath = TestPath(mockString, mockString, mockString)
        XCTAssert(path === expectedTestPath)

        let expectedPath: Path = expectedTestPath
        XCTAssert(path === expectedPath)
    }

    // MARK: ==<Path, String>

    func testEquatableToString() {
        XCTAssert(path == mockString)
    }
}
