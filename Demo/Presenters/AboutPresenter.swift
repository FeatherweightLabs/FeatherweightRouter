//
//  AboutPresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 9/02/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func aboutPresenter(store: AppStore) -> UIRouterDelegate {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (128, 192, 256),
        title: "About",
        callToActionTitle: "Go to '/welcome/login/'",
        callToActionRoute: "welcome/login"))

    return RouterDelegate() { viewController }
}
