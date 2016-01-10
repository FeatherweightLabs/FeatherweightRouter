//
//  CallbackCollection.swift
//  Beeline
//
//  Created by Karl Bowden on 11/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

/**
 A Collection of Callbacks

 A wrapper for callbacks that get called once then cleared.

 It allows for an array of callbacks to be associated with a value type in the same way as a
 delegate does on a class.
 */
public class CallbackCollection<Callback>: SequenceType {

    var contents: [Callback] = []

    public typealias Generator = AnyGenerator<Callback>

    /**
     Generator<Callback> abstraction

     - returns: Generator<Callback>
     */
    public func generate() -> Generator {
        var index = 0
        return anyGenerator {
            if index < self.contents.count {
                return self.contents[index++]
            }
            return nil
        }
    }

    /**
     Add a new callback to the collection to receive the emit event once, or never if this class is
     destroyed.

     - parameter item: Callback
     */
    public func append(item: Callback) {
        contents.append(item)
    }

    /**
     Execute the callback with each item in the callback collection.

     - parameter callback: Callback: (Callback -> Void)
     */
    public func emit(callback: Callback -> Void) {
        contents.forEach(callback)
        contents = []
    }

}
