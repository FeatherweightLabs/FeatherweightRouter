//
//  ZippedStackTests.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import Beeline

class ZippedStackTests: XCTestCase {

    let emptyStack = [String]()
    let stackAB = ["A", "B"]
    let stackCD = ["C", "D"]
    let stack12 = ["1", "2"]
    let stack123 = ["1", "2", "3"]
    let stackABC = ["A", "B", "C"]
    let stackBCD = ["B", "C", "D"]
    let stackABCD = ["A", "B", "C", "D"]
    let stackAB12 = ["A", "B", "1", "2"]
    let stack1234 = ["1", "2", "3", "4"]

    func testDiffSame() {
        let tStack = ZippedStack(stackAB, stackAB)
        XCTAssertEqual(tStack.common, stackAB)
        XCTAssertEqual(tStack.from, emptyStack)
        XCTAssertEqual(tStack.to, emptyStack)
    }

    func testDiffRight() {
        let tStack = ZippedStack(stackAB, stackABCD)
        XCTAssertEqual(tStack.common, stackAB)
        XCTAssertEqual(tStack.from, emptyStack)
        XCTAssertEqual(tStack.to, stackCD)
    }

    func testDiffCommon() {
        let tStack = ZippedStack(stackABCD, stackAB12)
        XCTAssertEqual(tStack.common, stackAB)
        XCTAssertEqual(tStack.from, stackCD)
        XCTAssertEqual(tStack.to, stack12)
    }

    func testDiffNoCommon() {
        let tStack = ZippedStack(stackABCD, stack1234)
        XCTAssertEqual(tStack.common, emptyStack)
        XCTAssertEqual(tStack.from, stackABCD)
        XCTAssertEqual(tStack.to, stack1234)
    }

    func testDiffEmpty() {
        let tStack = ZippedStack(emptyStack, emptyStack)
        XCTAssertEqual(tStack.common, emptyStack)
        XCTAssertEqual(tStack.from, emptyStack)
        XCTAssertEqual(tStack.to, emptyStack)
    }

    func testEquatable() {
        let testStack1 = ZippedStack(stackABCD, stackAB12)
        let testStack2 = ZippedStack(stackABCD, stackAB12)
        let testStack3 = ZippedStack(stackABCD, stack1234)
        XCTAssertEqual(testStack1, testStack2)
        XCTAssertNotEqual(testStack1, testStack3)
    }

    func testPopFrom() {
        let startStack = ZippedStack(stack1234, stackABCD)
        let (poppedItem, poppedStack) = startStack.popFrom()
        let targetStack = ZippedStack(stack123, stackABCD)
        XCTAssertEqual(poppedItem, "4")
        XCTAssertEqual(poppedStack, targetStack)
    }

    func testPopTo() {
        let startStack = ZippedStack(stack1234, stackABCD)
        let (poppedItem, poppedStack) = startStack.popTo()
        let targetStack = ZippedStack(stack1234, stackBCD)
        XCTAssertEqual(poppedItem, "A")
        XCTAssertEqual(poppedStack, targetStack)
    }
}
