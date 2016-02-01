//
//  WelcomeViewModel.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

protocol ProvidesRouteDispatch {
    func dispatchRoute(_: String)
}

struct WelcomeViewModel: ProvidesColor {

    let backgroundColor = UIColor.purpleColor()

    let store: ProvidesRouteDispatch

    init(store: ProvidesRouteDispatch) {
        self.store = store
    }

    func navigateToLogin() {
        store.dispatchRoute("welcome/login")
    }

    func navigateToRegister() {
        store.dispatchRoute("welcome/register")
    }

    func navigateToStep2() {
        store.dispatchRoute("welcome/register/step2")
    }

}
