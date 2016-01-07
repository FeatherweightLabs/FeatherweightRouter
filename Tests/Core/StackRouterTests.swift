//
//  StackRouterTests.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import Beeline

class StackRouterTests: XCTestCase {

    // MARK: Mocks

    class TestPresenter: SegmentViewCreator {

        let viewController = UIViewController()

        func create(path: Path) -> UIViewController {
            return viewController
        }

    }

    class TestStackViewController: StackViewController {
        var internalStack: [Segment] = []

        override func setStack(newStack: [Segment]) {
            internalStack = newStack
        }

    }

    // MARK: Testables

    var testViewController: TestStackViewController!
    var router: Router!

    // MARK: Setup
    override func setUp() {
        super.setUp()
        testViewController = TestStackViewController()
        router = StackRouter("", [
            Route("a", TestPresenter(), [
                Route("\\d+", TestPresenter(), []),
                Route("🦁", TestPresenter(), []),
                ]),
            Route("👍", TestPresenter(), []),
            Route("\\w+", TestPresenter(), []),
            ], testViewController)
    }

    // MARK: - Tests

    func testSetPath() {
        let tests = [
            "/a/": (success: true, path: "a", pattern: "a"),
            "👍": (success: false, path: "", pattern: ""),
            "/a/🦁/": (success: false, path: "", pattern: ""),
            "a/2": (success: true, path: "a/2", pattern: "a/\\d+"),
            "word": (success: true, path: "word", pattern: "\\w+"),
            "a": (success: true, path: "a", pattern: "a"),
            "no match": (success: false, path: "",    pattern: ""),
            "no/match": (success: false, path: "",    pattern: ""),
        ]
        for (path, expected) in tests {
            let success = router.setPath(URLPath(path))
            let stack = testViewController.internalStack
            let pathResult = stack.map { $0.path.path }.joinWithSeparator("/")
            let patternResult = stack.map { $0.path.pattern }.joinWithSeparator("/")

            XCTAssertEqual(success, expected.success)
            if success {
                XCTAssertEqual(pathResult, expected.path)
                XCTAssertEqual(patternResult, expected.pattern)
            }
        }
    }

}
