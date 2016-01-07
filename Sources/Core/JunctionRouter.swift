//
//  JunctionRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//


public struct JunctionRouter {

}

extension JunctionRouter: Router {

    public func handlesPath(path: Path) -> Bool {
        return false
    }

    public func setPath(path: Path) -> Bool {
        return false
    }
}
