//
//  RouterDelegate.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 28/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

public struct RouterDelegate<T> {

    public var getPresenter: Void -> T
    public var setChild: T -> Void = { _ in }
    public var setChildren: [T] -> Void = { _ in }

    public var presenter: T { return getPresenter() }

    public func set(child: T) {
        setChild(child)
    }

    public func set(children: [T]) {
        setChildren(children)
    }

    public init(getPresenter: Void -> T) {
        self.getPresenter = getPresenter
    }
}
