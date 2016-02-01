//
//  AppCoordinator.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

typealias UIRouterDelegate = RouterDelegate<UIViewController>

func appCoordinator() -> UIViewController {

    var router: Router<UIViewController>!
    let store = AppStore() { router.setRoute($0) }
    router = createRouter(store)

    store.setPath("welcome")

    return router.presenter
}


func createRouter(store: AppStore) -> Router<UIViewController> {

    return Router(navigationController()).stack([
        Router(welcomePresenter(store)).route("welcome", children: [
            Router(registrationPresenter(store)).route("welcome/register", children: [
                Router(step2Presenter(store)).route("welcome/register/step2"),
                ]),
            Router(loginPresenter(store)).route("welcome/login"),
            ])
        ])
}

func navigationController() -> UIRouterDelegate {
    let navigationController = UINavigationController()

    var delegate: UIRouterDelegate = RouterDelegate() { navigationController }
    delegate.setChild = { print($0) }
    delegate.setChildren = { navigationController.setViewControllers($0, animated: true) }

    return delegate
}
