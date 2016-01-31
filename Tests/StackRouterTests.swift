//
//  StackRouterTests.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import FeatherweightRouter

class StackRouterTests: XCTestCase {

    // MARK: Mocks

    class TestPresenter: SegmentViewCreator {

        func create(path: Path, dismiss: (Path) -> ()) -> RouterViewController {
            return UIRouterViewController(path: path, dismiss: dismiss)
        }

    }

    class TestStackViewController: StackViewController {
        var dismissViewController: Path -> () = { _ in }
        var internalStack: [Segment] = []

        func setStack(currentStack: [Segment], newStack: [Segment]) -> [Segment] {
            internalStack = newStack
            return newStack
        }

        func performActions(actionStack: [TransitionAction]) throws {}

    }

    // MARK: Testables

    var testViewController: TestStackViewController!
    var router: StackRouter!

    // MARK: Setup
    override func setUp() {
        super.setUp()
        testViewController = TestStackViewController()
        router = createRouter([
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
