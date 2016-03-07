/**

 To control the display or change of route, each router needs a presenter to hand off to. The
 presenter separates the route tree from interface code.

 The actual presenter is owned by the presenter which can control the lifecycle of ViewControllers.

 */
public struct Presenter<T> {

    /// Returns the child presenter
    public var getPresentable: Void -> T

    /// Sets the child value to the passed in presenter
    public var setChild: T -> Void = { _ in fatalError("Call to unset setChild") }

    /// Sets the children value to passed in presenters
    public var setChildren: [T] -> Void = { _ in fatalError("Call to unset setChildren") }

    /// The owned presenter
    public var presentable: T { return getPresentable() }

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
     Presenter initialiser

     - parameter getPresentable: Returns the owned presenter
     - parameter setChild:       Callback action to set the child presenter
     - parameter setChildren:    Callback to set the children presenters
     */
    public init(getPresentable: Void -> T, setChild: (T -> Void)? = nil,
        setChildren: ([T] -> Void)? = nil) {
            self.getPresentable = getPresentable
            if let setChild = setChild {
                self.setChild = setChild
            }
            if let setChildren = setChildren {
                self.setChildren = setChildren
            }
    }
}
