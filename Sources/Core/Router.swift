//
//  Router.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public protocol Router {

    func handlesPath(path: Path) -> Bool

    func setPath(path: Path) -> Bool
}
