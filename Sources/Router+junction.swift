//
//  Router+junction.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 27/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

extension Router {

    public func junction(junctions: [Router<T>]) -> Router<T> {

        var router = self

        router.handlesRoute = { path in
            return junctions.contains { $0.handlesRoute(path) }
        }

        router.setRoute = { path in
            router.delegate.set(junctions.map { $0.presenter })
            if let junction = junctions.pickFirst({ $0.handlesRoute(path) ? $0 : nil }) {
                router.delegate.set(junction.presenter)
            }
        }

        return router
    }

}
