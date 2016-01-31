//
//  Router+stack.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 27/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

extension Router {

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
