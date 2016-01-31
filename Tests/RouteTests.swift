//
//  RouteTests.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
import UIKit
@testable import FeatherweightRouter

class RouteTests: XCTestCase {

    class TestPresenter: SegmentViewCreator {

        func create(path: Path, dismiss: (Path) -> ()) -> RouterViewController {
            return UIRouterViewController(path: path, dismiss: dismiss)
        }

    }

    func testInit() {
        let route: Route? = Route("", TestPresenter())
        XCTAssert(route != nil)
    }

    func testMatch() {
        let route = Route("home", TestPresenter())
        XCTAssert(route.handlesPath(URLPath("home")))
    }

    func testMatchEmojiFailure() {
        let thumbsup = "👍"
        XCTAssertFalse(URLPath("👍").matchesPattern("^👍(/|$)"))
        XCTAssertFalse(URLPath("👍").matchesPattern("^\(thumbsup)(/|$)"))
        XCTAssertFalse(Route("👍", TestPresenter()).handlesPath(URLPath("👍")))
    }

    func testBuildFailure() {
        let route = Route("a", TestPresenter(), [Route("b", TestPresenter())])
        XCTAssertNil(route.build(URLPath("NOPE")))
    }

    func testBuildFullMatchOnly() {
        let route = Route("a", TestPresenter(), [Route("b", TestPresenter())])
        XCTAssertNil(route.build(URLPath("a/b/c")))
    }

    func testBuildSingle() {
        let route = Route("a", TestPresenter(), [Route("b", TestPresenter())])
        let build = route.build(URLPath("a"))
        XCTAssert(build != nil && build!.count == 1)
    }

    func testBuildMultiple() {
        let route = Route("a", TestPresenter(), [Route("b", TestPresenter())])
        let build = route.build(URLPath("a/b"))
        XCTAssert(build != nil && build!.count == 2)
    }

    func testBuildSingleEmojiFailure() {
        let route = Route("👍", TestPresenter())
        let build = route.build(URLPath("👍"))
        XCTAssertNil(build)
    }

    func testBuildMultipleEmojiFailure() {
        let route = Route("👍", TestPresenter(), [Route("😎", TestPresenter())])
        let build = route.build(URLPath("👍/😎"))
        XCTAssertNil(build)
    }

}
