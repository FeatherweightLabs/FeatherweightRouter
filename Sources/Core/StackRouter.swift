//
//  StackRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

public struct StackRouter {

    public let pattern: String

    public let children: [Route]

    public let viewController: StackViewController

    public init(_ pattern: String, _ children: [Route], _ viewControler: StackViewController) {
        self.pattern = pattern
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
        guard let (_, remainder) = path.splitBy(pattern) else { return false }
        return children.contains { $0.handlesPath(remainder) }
    }

    public func setPath(path: Path) -> Bool {
        guard let (_, remainder) = path.splitBy(pattern) else { return false }
        guard let newStack = pathStack(remainder) else { return false }
        viewController.setStack(newStack)
        return true
    }

    public func create() -> UIViewController {
        return viewController
    }

}
