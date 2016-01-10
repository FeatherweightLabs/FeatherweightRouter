//
//  RouterViewController.swift
//  Beeline
//
//  Created by Aleksander Herforth Rendtslev on 07/01/16.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

/**
 Standard RouterViewController Protocol
 This must be implemented by both the iOS and Appkit implementation
 */
public protocol RouterViewController {
    var path: Path {get}
    var dismiss: (Path) -> Void  {get}
    init(path: Path, dismiss: (Path) -> Void)
}

/**
 UIViewController implementation of the RouterViewController.
 */
public class UIRouterViewController: UIViewController, RouterViewController {

    public var path: Path
    public var dismiss: (Path) -> Void

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public required init(path: Path, dismiss: (Path) -> Void) {
        self.path = path
        self.dismiss = dismiss
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParentViewController() {
            // Your code...
            print("I am going back")
            dismiss(path)
        }
    }

}
