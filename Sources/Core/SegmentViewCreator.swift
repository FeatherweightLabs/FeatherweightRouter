//
//  SegmentViewCreator.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 5/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

public protocol SegmentViewCreator {
    func create(path: Path) -> RouterViewController
}
