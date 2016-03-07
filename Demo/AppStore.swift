class AppStore: ProvidesRouteDispatch {

    var setPath: String -> Void!

    init(setPath: String -> Void) {
        self.setPath = setPath
    }

    func dispatchRoute(string: String) {
        setPath(string)
    }
}
