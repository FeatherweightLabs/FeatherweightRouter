//
//  WelcomeViewController.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import Beeline

class WelcomeViewController: UIRouterViewController {

    let viewModel: WelcomeViewModel

    private var welcomeView: WelcomeView! { return self.view as! WelcomeView }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: WelcomeViewModel, path: Path, dismiss: (Path) -> ()) {
        self.viewModel = viewModel
        super.init(path: path, dismiss: dismiss);
    }
    
    internal required init(path: Path, dismiss: (Path) -> Void) {
        fatalError("init(path:dismiss:) has not been implemented")
    }

    override func loadView() {
        view = WelcomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.loginButton.addTarget(self, action: Selector("didClickLogin:"),
            forControlEvents: .TouchUpInside)
        welcomeView.registerButton.addTarget(self, action: Selector("didClickRegister:"),
            forControlEvents: .TouchUpInside)
        view.backgroundColor = viewModel.backgroundColor
    }

    func didClickLogin(button: UIButton) {
        print(navigationController?.viewControllers.count);
        viewModel.navigateToLogin()
    }

    func didClickRegister(button: UIButton) {
        viewModel.navigateToRegister()
    }
}
