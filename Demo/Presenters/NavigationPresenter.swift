//
//  NavigationPresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 9/02/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit
import FeatherweightRouter

func navigationPresenter(title: String) -> UIRouterDelegate {

    let navigationController = UINavigationController()
    navigationController.tabBarItem.title = title
    navigationController.tabBarItem.image = UIImage(named: "placeholder-icon")

    return RouterDelegate(
        getPresenter: { navigationController },
        setChild: { _ in },
        setChildren: { navigationController.setViewControllers($0, animated: true) })
}