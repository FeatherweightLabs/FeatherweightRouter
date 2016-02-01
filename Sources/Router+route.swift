//
//  Router+route.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 27/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

extension Router {

    public func route(pattern: String) -> Router<T> {

        var router = self

        router.handlesRoute = { "^\(pattern)$".regexMatch($0) }

        router.getStack = { router.handlesRoute($0) ? [router.delegate.presenter] : nil }

        return router
    }

    public func route(pattern: String, children: [Router<T>]) -> Router<T> {

        var router = self
        let matchPattern = "^\(pattern)$"

        func match(string: String) -> Bool {
            return matchPattern.regexMatch(string)
        }

        router.handlesRoute = { path in
            return match(path) || children.contains { $0.handlesRoute(path) } ?? false
        }

        router.getStack = { path in
            if match(path) {
                return [router.delegate.presenter]
            }
            for child in children {
                if let stack = child.getStack(path) {
                    return [router.delegate.presenter] + stack
                }
            }
            return nil
        }

        return router
    }

}
