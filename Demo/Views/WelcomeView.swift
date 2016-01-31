//
//  WelcomeView.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

class WelcomeView: UIView {

    let loginButton = UIButton(type: .Custom)
    let registerButton = UIButton(type: .Custom)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect.zero)

        loginButton.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        loginButton.titleLabel?.text = "Login"
        loginButton.backgroundColor = UIColor.whiteColor()
        addSubview(loginButton)

        registerButton.frame = CGRect(x: 50, y: 250, width: 100, height: 100)
        registerButton.titleLabel?.text = "Register"
        registerButton.backgroundColor = UIColor.blackColor()
        addSubview(registerButton)
    }
}
