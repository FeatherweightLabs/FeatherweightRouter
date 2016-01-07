//
//  FormPresenter.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import Beeline
import UIKit

struct RegistrationPresenter: SegmentViewCreator {

    func create(path: Path) -> UIViewController {
        return FormViewController(ColorViewModel(UIColor.blueColor()))
    }

}
