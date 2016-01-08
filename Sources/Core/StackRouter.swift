//
//  StackRouter.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public struct StackRouter {
    public var setPath : (String) -> Bool;
    public var pathStack : (Path) -> [Segment]?
    public var dismissViewController: (Path) -> ();
    
    public init(
        setPath: (String) -> Bool,
        pathStack: (Path) -> [Segment]?,
        dismissViewController: (Path) -> ()) {
            self.setPath = setPath;
            self.pathStack = pathStack;
            self.dismissViewController = dismissViewController;
    }
}

public func createRouter(_ routes: [Route],_ viewControler: StackViewController) -> StackRouter {
    let routes: [Route] = routes;
    var routerViewController: StackViewController = viewControler;
    var previousStack: [Segment] = [];
    var currentStack: [Segment] = [];
    
    func setPath(string: String) -> Bool {
        return innerSetPath(URLPath(string))
    }
    
    func innerSetPath(path: Path) -> Bool { // TODO: Throw
        guard let newStack = pathStack(path) else { return false }
        let tempStack = currentStack;
        currentStack = routerViewController.setStack(currentStack, newStack: newStack);
        previousStack = tempStack;
        return true
    }
    
    func pathStack(path: Path) -> [Segment]? {
        for route in routes {
            if let stack = route.build(path) {
                return stack
            }
        }
        return nil
    }
    
    func dissmissViewController(path: Path) {
        currentStack = previousStack;
    }
    
    /**
    *  Add the dismissViewController to the routerViewController so the stackRouter can be notified when a viewController is being dismissed
    */
    routerViewController.dismissViewController = dissmissViewController;

    
    return StackRouter(setPath: setPath,  pathStack: pathStack, dismissViewController: dissmissViewController);

}
