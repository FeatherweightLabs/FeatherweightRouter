//
//  Segment.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

/**
 Segment: A path combined with a view creator

 Path + Route = Segment
 Route.ViewCreator + Path + State = View

 After creating a sprout it should should be comparable to other sprouts that generate the same view.

 Segments are a simple way of turning a route + path state into an equatable.
 */
public struct Segment: Equatable {

    let path: Path
    let segmentViewCreator: SegmentViewCreator

    init(path: Path, segmentViewCreator: SegmentViewCreator) {
        self.path = path
        self.segmentViewCreator = segmentViewCreator
    }

    func create() -> UIViewController {
        return segmentViewCreator.create(path)
    }

}

public func ==(lhs: Segment, rhs: Segment) -> Bool {
    return lhs.path === rhs.path
}
