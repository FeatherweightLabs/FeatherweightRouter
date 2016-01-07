//
//  StackRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

public struct StackRouter {

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

extension StackRouter: Router {

    public func handlesPath(path: Path) -> Bool {
        return children.contains { $0.handlesPath(path) }
    }

    public func setPath(path: Path) -> Bool {
        guard let newStack = pathStack(path) else { return false }
        viewController.setStack(newStack)
        return true
    }

    public func create(path: Path) -> UIViewController {
        return viewController
    }

}
