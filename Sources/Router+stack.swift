//
//  Router+stack.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 27/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

extension Router {

    /**
     Stack Router

     Photos of every town you drive through to get to the destination. You may not be able to see
     the alternative paths, but you can navigate back to the start by traveling back through the
     waypoints in the stack.

     The Stack router behaviour is analogous to NavigationControllers.

     - parameter stack: Array of routes that may also have child routes.

     - returns: A customised copy of Router<T>
     */
    public func stack(stack: [Router<T>]) -> Router<T> {

        var router = self

        router.handlesRoute = { path in
            return stack.contains { $0.handlesRoute(path) }
        }

        router.setRoute = { path in
            router.delegate.set(stack.pickFirst { $0.getStack(path) } ?? [])
        }

        return router
    }
}
