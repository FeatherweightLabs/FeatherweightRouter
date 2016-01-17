//
//  AppCoordinator.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func appCoordinator() -> UIViewController {

    var router: StackRouter!
    let store = AppStore(setPath: { router.setPath(URLPath($0)) })

    router = createRouter(store)

    store.setPath("welcome")

    return router.viewController
}

func createRouter(store: AppStore) -> StackRouter {

    return StackRouter("", [
        Route("welcome", WelcomePresenter(store), [
            Route("login", LoginPresenter()),
            Route("register", RegistrationPresenter()),
            ]),
        ], StackViewController())
}
