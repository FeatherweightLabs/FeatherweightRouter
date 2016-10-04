class AppStore: ProvidesRouteDispatch {

    var setPath: (String) -> Void!

    init(setPath: @escaping (String) -> Void) {
        self.setPath = setPath
    }

    func dispatchRoute(_ string: String) {
        setPath(string)
    }
}
