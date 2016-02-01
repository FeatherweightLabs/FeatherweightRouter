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

    let viewController = FormViewController(ColorViewModel(UIColor.blueColor()))

    return RouterDelegate() { viewController }
}

func step2Presenter(store: AppStore) -> UIRouterDelegate {

    let viewController = FormViewController(ColorViewModel(UIColor.cyanColor()))

    return RouterDelegate() { viewController }
}
