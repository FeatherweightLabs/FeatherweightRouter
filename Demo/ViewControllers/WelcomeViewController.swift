//
//  WelcomeViewController.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    let viewModel: WelcomeViewModel

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var step2Button: UIButton!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addAction(.TouchUpInside) { [unowned self] _ in
            self.viewModel.navigateToLogin()
        }

        registerButton.addAction(.TouchUpInside) { [unowned self] _ in
            self.viewModel.navigateToRegister()
        }

        step2Button.addAction(.TouchUpInside) { [unowned self] _ in
            self.viewModel.navigateToStep2()
        }

        view.backgroundColor = viewModel.backgroundColor
    }

}
