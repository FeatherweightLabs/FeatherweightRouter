//
//  AppCoordinator.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import Beeline

func appCoordinator() -> UIViewController {

    var router: StackRouter!
    let navigationController = UIStackViewController()
    let store = AppStore(setPath: {
        print("New path: \($0)")
        router.setPath(URLPath($0))
    })

    router = createRouter([
        Route("welcome", WelcomePresenter(store), [
            Route("login", LoginPresenter()),
            Route("register", RegistrationPresenter()),
            ]),
        ], navigationController)

    store.setPath("welcome")

    return navigationController
}
