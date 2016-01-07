//
//  Beeline.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public struct Route {

    public let pattern: String
    public var children: [Route]
    public let segmentViewCreator: SegmentViewCreator

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

    public init(_ pattern: String, _ creator: SegmentViewCreator, _ children: [Route] = []) {
        self.pattern = pattern
        segmentViewCreator = creator
        self.children = children
    }
}
