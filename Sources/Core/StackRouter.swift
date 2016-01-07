//
//  StackRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public struct StackRouter {

    let routes: [Route]

    let routerViewController: StackViewController

    public init(_ routes: [Route], _ viewControler: StackViewController) {
        self.routes = routes
        self.routerViewController = viewControler
    }

    public func setPath(string: String) -> Bool {
        return setPath(URLPath(string))
    }

    public func setPath(path: Path) -> Bool { // TODO: Throw
        guard let newStack = pathStack(path) else { return false }
        routerViewController.setStack(newStack)
        return true
    }

    public func pathStack(path: Path) -> [Segment]? {
        for route in routes {
            if let stack = route.build(path) {
                return stack
            }
        }
        return nil
    }
    
}

