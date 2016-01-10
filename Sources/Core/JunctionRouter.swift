//
//  JunctionRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

/**
 JunctionRoute: A router of routers. Would typically map to a TabBarController.

 The junction router is created with a list of child routers and a view controller to delegate to.

 When a path is passed in, child view controllers are search for a match and if found, the matched
 path segment is popped of the path, the view controller is activated and then finally the remainder
 of the path is passed to the activated router.
 */
public struct JunctionRouter {

    public let pattern: String

    public let children: [Router]

    public let viewController: JunctionViewController

    public init(_ pattern: String, _ children: [Router], _ viewControler: JunctionViewController) {
        self.pattern = pattern
        self.children = children
        self.viewController = viewControler
        let childViewControllers = children.map { $0.create() }
        viewController.setViewControllers(childViewControllers, animated: false)
    }

}

extension JunctionRouter: Router {

    public func handlesPath(path: Path) -> Bool {
        guard let (_, remainder) = path.splitBy(pattern) else { return false }
        return children.contains { $0.handlesPath(remainder) }
    }

    public func setPath(path: Path) -> Bool {
        guard let (_, remainder) = path.splitBy(pattern) else { return false }
        for child in children {
            if child.handlesPath(remainder) {
                viewController.selectedViewController = child.create()
                return true
            }
        }
        return false
    }

    public func create() -> UIViewController {
        return viewController
    }

}
