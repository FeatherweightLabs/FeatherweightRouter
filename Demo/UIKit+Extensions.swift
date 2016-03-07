import UIKit

// Source: https://www.mikeash.com/pyblog/friday-qa-2015-12-25-swifty-targetaction.html

class ActionTrampoline<T>: NSObject {
    var action: T -> Void

    init(action: T -> Void) {
        self.action = action
    }

    // swiftlint:disable force_cast
    @objc func action(sender: UIControl) {
        action(sender as! T)
    }
}

let uiControlAssociatedFunctionObject = UnsafeMutablePointer<Int8>.alloc(1)

protocol UIControlActionFunctionProtocol { }

extension UIControlActionFunctionProtocol where Self: UIControl {

    func addAction(events: UIControlEvents, _ action: Self -> Void) {
        let trampoline = ActionTrampoline(action: action)
        self.addTarget(trampoline, action: "action:", forControlEvents: events)
        objc_setAssociatedObject(self, uiControlAssociatedFunctionObject,
            trampoline, .OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIControl: UIControlActionFunctionProtocol { }
