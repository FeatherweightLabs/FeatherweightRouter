//
//  RouteTests.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import Beeline

class RouteTests: XCTestCase {

    struct TestSegmentViewController: SegmentViewController {}

    struct TestSegmentViewCreator: SegmentViewCreator {

        func create(path: Path) -> SegmentViewController {
            return TestSegmentViewController()
        }

    }

    struct TestRoute: Route {

        let pattern: String
        let children: [Route]
        let segmentViewCreator: SegmentViewCreator

        init(_ pattern: String = "", children: [Route] = []) {
            self.pattern = pattern
            self.children = children
            self.segmentViewCreator = TestSegmentViewCreator()
        }
    }

    func testInit() {
        let route: Route? = TestRoute()
        XCTAssert(route != nil)
    }

    func testMatch() {
        let route = TestRoute("home")
        let matches = route.match(URLPath("home"))
        XCTAssert(matches)
    }

    func testMatchEmojiFailure() {
        let thumbsup = "👍"
        XCTAssertFalse(URLPath("👍").matchesPattern("^👍(/|$)"))
        XCTAssertFalse(URLPath("👍").matchesPattern("^\(thumbsup)(/|$)"))
        XCTAssertFalse(TestRoute("👍").match(URLPath("👍")))
    }

    func testBuildFailure() {
        let route = TestRoute("a", children: [TestRoute("b")])
        XCTAssertNil(route.build(URLPath("NOPE")))
    }

    func testBuildFullMatchOnly() {
        let route = TestRoute("a", children: [TestRoute("b")])
        XCTAssertNil(route.build(URLPath("a/b/c")))
    }

    func testBuildSingle() {
        let route = TestRoute("a", children: [TestRoute("b")])
        let build = route.build(URLPath("a"))
        XCTAssert(build != nil && build!.count == 1)
    }

    func testBuildMultiple() {
        let route = TestRoute("a", children: [TestRoute("b")])
        let build = route.build(URLPath("a/b"))
        XCTAssert(build != nil && build!.count == 2)
    }

    func testBuildSingleEmojiFailure() {
        let route = TestRoute("👍")
        let build = route.build(URLPath("👍"))
        XCTAssertNil(build)
    }

    func testBuildMultipleEmojiFailure() {
        let route = TestRoute("👍", children: [TestRoute("😎")])
        let build = route.build(URLPath("👍/😎"))
        XCTAssertNil(build)
    }

}
