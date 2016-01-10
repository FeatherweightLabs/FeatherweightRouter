//
//  DismissEmitter.swift
//  Beeline
//
//  Created by Karl Bowden on 11/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public typealias DismissCallback = () -> Void
public typealias DismissCallbacks = CallbackCollection<DismissCallback>

/**
 The DismissEmitter protocol allows for callbacks to be added to a collection that will get called
 once when the emitDismiss function is fired, then disposed of.

 Be weary of causeing strong references when adding callbacks.

 Recommended usage:

 ```swift
 someitem.onDismiss { [unowned self] in
     self.doSomething()
 }
 ```
 */
public protocol DismissEmitter {

    var dismissCallbacks: DismissCallbacks { get set }

    func onDismiss(callback: DismissCallback)

    func emitDismiss()
}

extension DismissEmitter {

    public func onDismiss(callback: DismissCallback) {
        dismissCallbacks.append(callback)
    }

    public func emitDismiss() {
        dismissCallbacks.emit { $0() }
    }

}
