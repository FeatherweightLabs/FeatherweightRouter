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

    struct MockSegmentViewController: SegmentViewController {}

    struct MockSegmentViewCreator: SegmentViewCreator {
        func create(path: Path) -> SegmentViewController {
            return MockSegmentViewController()
        }
    }

    struct MockRoute: Route {

        let pattern: String
        let children: [Route]
        let segmentViewCreator: SegmentViewCreator

        init(_ pattern: String = "", _ children: [Route] = []) {
            self.pattern = pattern
            self.children = children
            self.segmentViewCreator = MockSegmentViewCreator()
        }
    }

    class SegmentStack {
        var stack: [Segment] = []
        init() {}
    }

    struct MockRouterController: StackRouterViewController {
        let internalStack = SegmentStack()
        var stack: [Segment] = []
        func setStack(stack: [Segment]) {
            internalStack.stack = stack
        }
        init() {}
    }

    // MARK: Testables

    struct TestStackRouter: StackRouter {
        let routes: [Route]
        let routerViewController: StackRouterViewController
        init(_ routes: [Route], _ routerViewController: StackRouterViewController) {
            self.routes = routes
            self.routerViewController = routerViewController
        }
    }

    // MARK: Variables

    var mockRouterController: MockRouterController!
    var router: Router!

    // MARK: Setup
    override func setUp() {
        super.setUp()
        mockRouterController = MockRouterController()
        router = TestStackRouter([
            MockRoute("a", [
                MockRoute("\\d+", []),
                MockRoute("🦁", []),
                ]),
            MockRoute("👍", []),
            MockRoute("\\w+", []),
            ], mockRouterController)
    }

    // MARK: - Tests

    func testSetPath() {
        let tests = [
            "/a/":      (success: true,  path: "a",    pattern: "a"),
            "👍":       (success: false, path: "",     pattern: ""),
            "/a/🦁/":   (success: false, path: "",     pattern: ""),
            "a/2":      (success: true,  path: "a/2",  pattern: "a/\\d+"),
            "word":     (success: true,  path: "word", pattern: "\\w+"),
            "a":        (success: true,  path: "a",    pattern: "a"),
            "no match": (success: false, path: "",    pattern: ""),
            "no/match": (success: false, path: "",    pattern: ""),
        ]
        for (path, expected) in tests {
            let success = router.setPath(path)
            let stack = mockRouterController.internalStack.stack
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
