//
//  Path.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public protocol Path {

    var path: String { get }

    var query: String { get }

    var pattern: String { get }

    init(_: String)

    func mutate(path path: String?, query: String?, pattern: String?) -> Path

    func matchesPattern(_: String) -> Bool

    func splitBy(_: String) -> (match: Path, remainder: Path)?
}

extension Path {

    public func matchesPattern(pattern: String) -> Bool {
        return Regex(pattern: "^\(pattern)(/|$)").matches(path).count > 0
    }

    public func splitBy(pattern: String) -> (match: Path, remainder: Path)? {
        guard let pathMatch = Regex(pattern: "^\(pattern)").match(path) else { return nil }
        guard let pathRemainder = Regex(pattern: "^\(pattern)(/|$)").replace(path) else { return nil }
        return (mutate(path: pathMatch, query: nil, pattern: pattern), mutate(path: pathRemainder, query: nil, pattern: nil))
    }

}

public func ==(lhs: Path, rhs: Path) -> Bool {
    return lhs.path == rhs.path
}

public func ===(lhs: Path, rhs: Path) -> Bool {
    return lhs.path == rhs.path && lhs.query == rhs.query && lhs.pattern == rhs.pattern
}

public func ==(lhs: Path, rhs: String) -> Bool {
    return lhs.path == rhs
}

// MARK: Generic equatable

public func ==<T, U where T: Path, U: Path>(lhs: T, rhs: U) -> Bool {
    return lhs.path == rhs.path
}
