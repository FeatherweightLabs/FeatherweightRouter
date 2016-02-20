//
//  RouterDelegate.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 28/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

/**

 To control the display or change of route, each router needs a delegate to hand off to. The
 delegate separates the route tree from interface code.

 The actual presenter is owned by the delegate which can control the lifecycle of ViewControllers.

 */
public struct RouterDelegate<T> {

    /// Returns the child presenter
    public var getPresenter: Void -> T

    /// Sets the child value to the passed in presenter
    public var setChild: T -> Void = { _ in fatalError("Call to unset setChild") }

    /// Sets the children value to passed in presenters
    public var setChildren: [T] -> Void = { _ in fatalError("Call to unset setChildren") }

    /// The owned presenter
    public var presenter: T { return getPresenter() }

    /**
     Shorthand for the setChild function

     - parameter child: child presenter
     */
    public func set(child: T) {
        setChild(child)
    }

    /**
     Shorthand for the setChildren function

     - parameter children: presenter children
     */
    public func set(children: [T]) {
        setChildren(children)
    }

    /**
     DelegatePresenter initialiser

     - parameter getPresenter: Returns the owned presenter
     - parameter setChild:     Callback action to set the child presenter
     - parameter setChildren:  Callback to set the children presenters

     - returns: RouterDelegate<T>
     */
    public init(getPresenter: Void -> T, setChild: (T -> Void)? = nil,
        setChildren: ([T] -> Void)? = nil) {
            self.getPresenter = getPresenter
            if let setChild = setChild {
                self.setChild = setChild
            }
            if let setChildren = setChildren {
                self.setChildren = setChildren
            }
    }
}
