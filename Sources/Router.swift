//
//  Router.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 26/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public struct Router<T> {

    public var delegate: RouterDelegate<T>
    public var presenter: T { return delegate.presenter }
    public var handlesRoute: String -> Bool = { _ in false }
    public var setRoute: String -> Void = { _ in }
    public var getStack: String -> [T]? = { _ in nil }

    public init(
        _ delegate: RouterDelegate<T>,
        handlesRoute: (String -> Bool)? = nil,
        setRoute: (String -> Void)? = nil,
        getStack: (String -> [T]?)? = nil) {

        self.delegate = delegate

        if let handlesRoute = handlesRoute {
            self.handlesRoute = handlesRoute
        }

        if let setRoute = setRoute {
            self.setRoute = setRoute
        }

        if let getStack = getStack {
            self.getStack = getStack
        }
    }
}
