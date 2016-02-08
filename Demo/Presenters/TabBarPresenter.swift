//
//  TabBarPresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 9/02/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func tabBarPresenter() -> UIRouterDelegate {

    let tabBarController = UITabBarController()

    return RouterDelegate(
        getPresenter: { tabBarController },
        setChild: { tabBarController.selectedViewController = $0 },
        setChildren: { tabBarController.setViewControllers($0, animated: true) })
}
