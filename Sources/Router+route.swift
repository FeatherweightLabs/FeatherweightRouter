extension Router {

    /**
     Route extension

     A named destination. Unlike the Junction and Stack, Route is a valid endpoint. To drive to
     town, there may be multiple routes with varying junctions and paths to take, but the
     destination will remain the same.

     - parameter pattern: A String containing a regex that possibly matches to provided paths.
     - parameter children: Array of little Router children.

     - returns: A customised copy of Router<T>
     */
    public func route(pattern: String, children: [Router<T>] = []) -> Router<T> {

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
