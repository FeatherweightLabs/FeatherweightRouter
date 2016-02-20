//
//  LoginPresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func loginPresenter(store: AppStore) -> UIRouterDelegate {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (64, 255, 64),
        title: "Login",
        callToActionTitle: "Go to '/welcome/'",
        callToActionRoute: "welcome"))

    return RouterDelegate(getPresenter: { viewController})
}
