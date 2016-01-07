//
//  Path.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

/**
 Path: A subsection of a URL that is matchable against a regex.

 Matching always happens from the start of the path and only matches full path segments (a slash or
 the end of the string).
 */
public protocol Path {

    /**
     Just the path section of a URL. This string should usually be trimmed of slashes at the start
     and finish for consistancy, but the Path protocol does not enforce it to allow for exact URL's
     to be reconstructed.
     */
    var path: String { get }

    /**
     The query section of a URL. The section after the first question mark. Example,
     parameter=value.
     */
    var query: String { get }

    /**
     Pattern is probably not the best name. This is not a pattern that is matched on, it's just the
     pattern that happened to match this segment when it was split. It can be used to check if two
     paths, although different, had the same matcher. Ie, `/users/1/` and `/users/2/` are different,
     but the would both have the same pattern `/users/\d+/`.
     */
    var pattern: String { get }

    init(_: String)

    func mutate(path path: String?, query: String?, pattern: String?) -> Path

    func matchesPattern(_: String) -> Bool

    func splitBy(_: String) -> (match: Path, remainder: Path)?
}

extension Path {

    public func matchesPattern(pattern: String) -> Bool {
        return pattern == "" || Regex(pattern: "^\(pattern)(/|$)").matches(path).count > 0
    }

    public func splitBy(pattern: String) -> (match: Path, remainder: Path)? {
        if pattern == "" {
            return (mutate(path: "", query: nil, pattern: ""), self)
        }
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
