//
//  JunctionRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

public struct JunctionRouter {

    let children: [Route]

    let viewController: StackViewController

    public init(_ children: [Route], _ viewControler: StackViewController) {
        self.children = children
        self.viewController = viewControler
    }

    public func pathStack(path: Path) -> [Segment]? {
        for child in children {
            if let stack = child.build(path) {
                return stack
            }
        }
        return nil
    }

}

extension JunctionRouter: Router {

    public func handlesPath(path: Path) -> Bool {
        return false
    }

    public func setPath(path: Path) -> Bool {
        return false
    }

    public func create(path: Path) -> UIViewController {
        return viewController
    }

}
