extension Router {
    
    /**
     Route extension
     
     A named destination. Unlike the Junction and Stack, Route is a valid endpoint. To drive to
     town, there may be multiple routes with varying junctions and paths to take, but the
     destination will remain the same.
     
     - parameter predicate: A String containing a regex that possibly matches to provided paths.
     - parameter children: Array of little Router children.
     
     - returns: A customised copy of Router<T>
     */
    public func route(predicate pathMatches: @escaping ((Path) -> Bool),
                      children: [Router<ViewController, Path>] = [],
                      arguments: ((Path) -> RouteArguments)? = nil
        ) -> Router<ViewController, Path>
    {
        
        var router = self
        
        router.handlesRoute = { path in
            return pathMatches(path) || children.contains { $0.handlesRoute(path) }
        }
        
        router.getStack = { path in
            let routeOptions = arguments != nil ? arguments!(path) : nil
            if pathMatches(path) {
                return [router.getPresentable(options: routeOptions)]
            }
            for child in children {
                if let stack = child.getStack(path) {
                    return [router.getPresentable(options: routeOptions)] + stack
                }
            }
            return nil
        }
        
        return router
    }
}
