//
//  TransitionStack.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public struct ZippedStack<T where T: Equatable>: Equatable {

    let common: [T]
    let from: [T]
    let to: [T]

    init(_ from: [T], _ to: [T]) {
        let commonCount = countEqualSequence(from, to)
        self.common = Array(from.prefixUpTo(commonCount))
        self.from = Array(from.suffixFrom(commonCount))
        self.to = Array(to.suffixFrom(commonCount))
    }

    private init(common: [T], from: [T], to: [T]) {
        self.common = common
        self.from = from
        self.to = to
    }

    func popFrom() -> (item: T?, stack: ZippedStack<T>) {
        let newFrom = Array(from.prefixUpTo(from.count - 1))
        return (from.last,
            ZippedStack(common: common, from: newFrom, to: to))
    }

    func popTo() -> (item: T?, stack: ZippedStack<T>) {
        let newTo = Array(to.suffixFrom(1))
        return (to.first,
            ZippedStack(common: common, from: from, to: newTo))
    }

}

public func countEqualSequence<T where T: Equatable>(lhs: [T], _ rhs: [T]) -> Int {
    return lhs.reduce(0) { index, item in
        if rhs.count > index && item == rhs[index] {
            return index + 1
        }
        return index
    }
}

public func ==<T>(lhs: ZippedStack<T>, rhs: ZippedStack<T>) -> Bool {
    return
        lhs.common == rhs.common &&
        lhs.from == rhs.from &&
        lhs.to == rhs.to
}
