//
//  AppCoordinator.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import Beeline

func AppCoordinator() -> UIViewController {

    var router: StackRouter!
    let navigationController = StackViewController()
    let store = AppStore(setPath: { router.setPath($0) })

    router = StackRouter([
        Route("welcome", WelcomePresenter(store), [
            Route("login", LoginPresenter()),
            Route("register", RegistrationPresenter()),
            ]),
        ], navigationController)

    store.setPath("welcome")

    return navigationController
}
