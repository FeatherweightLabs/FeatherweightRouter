//
//  WelcomePresenter.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import Beeline
import UIKit

struct WelcomePresenter: SegmentViewCreator {

    let store: AppStore

    init(_ store: AppStore) {
        self.store = store
    }

    func create(path: Path) -> UIViewController {
        return WelcomeViewController(viewModel: WelcomeViewModel(store: store))
    }
}

