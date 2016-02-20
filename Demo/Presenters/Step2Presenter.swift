//
//  Step2Presenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 9/02/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func step2Presenter(store: AppStore) -> UIRouterDelegate {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (128, 255, 255),
        title: "Registration + Step 2",
        callToActionTitle: "Go to '/welcome/register/'",
        callToActionRoute: "welcome/register"))

    return RouterDelegate(getPresenter: { viewController})
}
