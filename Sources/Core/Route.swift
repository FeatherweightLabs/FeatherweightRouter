//
//  Beeline.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

/**
 Route: Constructed with patten, view creator and an array of child routes.

 Route is used to check it matches a path. It only matches a path if it and possibly combined with
 it's children, matches a path from beginning to end. Ie, for Route(pattern) == / != Path:
 Route("home") matches(==) Path("/home/")
 "home" == "/home/"
 "home" != "/home/no-match/"
 "home[page1,page2]" == "home"
 "home[page1,page2]" == "home/page1"
 "home[page1,page2]" == "/home/page1/"
 */
public struct Route {

    public let pattern: String
    public var children: [Route]
    public let segmentViewCreator: SegmentViewCreator

    public init(_ pattern: String, _ creator: SegmentViewCreator, _ children: [Route] = []) {
        self.pattern = pattern
        segmentViewCreator = creator
        self.children = children
    }

    public func handlesPath(path: Path) -> Bool {
        return build(path) != nil
    }

    public func build(path: Path) -> [Segment]? {
        guard let (match, remainder) = path.splitBy(pattern) else { return nil }
        let segmentMatch = [Segment(path: match, segmentViewCreator: segmentViewCreator)]
        if remainder == "" {
            return segmentMatch
        }
        for child in children {
            if let childSegment = child.build(remainder) {
                return segmentMatch + childSegment
            }
        }
        return nil
    }

}
