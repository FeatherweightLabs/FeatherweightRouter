//
//  RouterViewController.swift
//  FeatherweightRouter
//
//  Created by Aleksander Herforth Rendtslev on 07/01/16.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

/**
 Standard RouterViewController Protocol
 This must be implemented by both the iOS and Appkit implementation
 */
public protocol RouterViewController: DismissEmitter {
    init(path: Path)
}

/**
 UIViewController implementation of the RouterViewController.
 */
public class UIRouterViewController: UIViewController, RouterViewController {

    public var dismissCallbacks = DismissCallbacks()

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public required init(path: Path) {
        super.init(nibName: nil, bundle: nil)
    }

    /**
     didMoveToParentViewController is used as the dismiss emitter hook as when using
     UINavigationController, didMoveToParentViewController is not called until after a user 'swipes'
     a view away.

     - parameter parent: UIViewController?
     */
    public override func didMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            emitDismiss()
        }
        super.didMoveToParentViewController(parent)
    }

}
