//
//  Refactor.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 8/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

extension Array {

    func pickFirst<T>(f: Element -> T?) -> T? {
        for item in self {
            if let result = f(item) {
                return result
            }
        }
        return nil
    }

}

public struct ViewController<T> {
    public let create: (T) -> UIViewController

    public init(create: (T) -> UIViewController) {
        self.create = create
    }

}

public struct NavigationController<T> {

    public let create: (T) -> UINavigationController

    public init(create: (T) -> UINavigationController) {
        self.create = create
    }
}

public struct TabBarController<T> {

    public let create: (T) -> UITabBarController

    public init(create: (T) -> UITabBarController) {
        self.create = create
    }
}

public func nameViewController(name: String) -> UIViewController {
    return UIViewController()
}





public protocol HandlesStack {

    func setStack(_: [Segment])
}


public protocol PROTO_Router {

    typealias Delegate

    var handlesPath: Path -> Bool { get }

    var setPath: Path -> Bool { get }

    var delegate: Delegate { get }
}

public struct PROTO_StackRouter<Delegate where Delegate: HandlesStack>: PROTO_Router {

    public let handlesPath: Path -> Bool

    public let setPath: Path -> Bool

    public let delegate: Delegate

    public init(handlesPath: Path -> Bool, setPath: Path -> Bool, delegate: Delegate) {
        self.handlesPath = handlesPath
        self.setPath = setPath
        self.delegate = delegate
    }

    /**
     Creates a StackRouter that can convert given paths into stacks passed to the delegate.

     - parameter pattern:  A String usable as a Regex expression. Pattens only match from the start
                           of a path.
     - parameter children: An array of child routes.
     - parameter delegate: The delegate stack handler that displays the passed stacks.
     */
    public init(pattern: String, children: [Route] = [], delegate: Delegate) {

        handlesPath = { path in
            guard let (_, remainder) = path.splitBy(pattern) else { return false }
            return children.contains { $0.handlesPath(remainder) }
        }

        setPath = { path in
            guard let pathRemainder = path.replace(pattern, "") else { return false }
            guard let stack = buildStack(pathRemainder, children) else { return false }
            delegate.setStack(stack)
            return true
        }

        self.delegate = delegate
    }
}

public func buildStack(path: Path, _ routes: [Route]) -> [Segment]? {
    return routes.pickFirst({ $0.build(path) })
}
