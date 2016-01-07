//
//  WelcomeView.swift
//  Beeline
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
        super.init(frame: CGRectZero)

        loginButton.frame = CGRectMake(50, 100, 100, 100)
        loginButton.titleLabel?.text = "Login"
        loginButton.backgroundColor = UIColor.whiteColor()
        addSubview(loginButton)

        registerButton.frame = CGRectMake(50, 250, 100, 100)
        registerButton.titleLabel?.text = "Register"
        registerButton.backgroundColor = UIColor.blackColor()
        addSubview(registerButton)
    }
}
