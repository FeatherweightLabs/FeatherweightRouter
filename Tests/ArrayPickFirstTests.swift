//
//  ArrayPickFirstTests.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 31/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import XCTest
@testable import FeatherweightRouter

class ArrayPickFirstTests: XCTestCase {

    let sourceArray = [1, 2, 3, 4, 5, 6]

    func testPicksFirst() {
        let expected = 3
        let actual = sourceArray.pickFirst() { $0 > 2 ? $0 : nil }

        XCTAssertEqual(expected, actual)
    }
}
