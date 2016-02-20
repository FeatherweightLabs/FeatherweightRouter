//
//  FormPresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func registrationPresenter(store: AppStore) -> UIRouterDelegate {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (128, 128, 255),
        title: "Registration",
        callToActionTitle: "Go to '/about/'",
        callToActionRoute: "about"))

    return RouterDelegate(getPresenter: { viewController})
}
