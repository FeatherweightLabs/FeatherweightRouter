//
//  Router+junction.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 27/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

extension Router {

    /**
     Junction Router

     A fork in the road. You can see all the paths in front of you (setChildren), but can only
     drive down one path at a time (setChild).

     The junction function is a Router behaviour customiser. It replaces handlesRoute and setRoute
     with functions that behave like a Junction Router and returns a modified copy of the Router.

     - parameter junctions: [Router<T>], an array of child routers to present

     - returns: Router<T>, a customised copy of self
     */
    public func junction(junctions: [Router<T>]) -> Router<T> {

        var router = self

        router.handlesRoute = { path in
            return junctions.contains { $0.handlesRoute(path) }
        }

        router.setRoute = { path in
            // inform the junction delegate of the available children
            router.delegate.set(junctions.map { $0.presenter})

            if let junction = junctions.pickFirst({ $0.handlesRoute(path) ? $0 : nil}) {
                // if a child matches, pass the path to it
                junction.setRoute(path)
                // and set it as the active junction
                router.delegate.set(junction.presenter)
            }
        }

        return router
    }
}
