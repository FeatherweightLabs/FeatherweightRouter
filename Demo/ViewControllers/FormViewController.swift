//
//  FormViewController.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import Beeline

class FormViewController: UIRouterViewController {

    let viewModel: ProvidesColor

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ viewModel: ProvidesColor, path: Path, dismiss: (Path) -> ()) {
        self.viewModel = viewModel
        super.init(path: path, dismiss: dismiss)
    }

    internal required init(path: Path, dismiss: (Path) -> Void) {
        fatalError("init(path:dismiss:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewModel.backgroundColor
    }

}
