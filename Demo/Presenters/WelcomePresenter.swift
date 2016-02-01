//
//  WelcomePresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func welcomePresenter(store: AppStore) -> UIRouterDelegate {

    let viewController = WelcomeViewController(WelcomeViewModel(store: store))

    return RouterDelegate() { viewController }
}
