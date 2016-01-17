//
//  FormPresenter.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import FeatherweightRouter
import UIKit

struct RegistrationPresenter: SegmentViewCreator {

    func create(path: Path) -> RouterViewController {
        return FormViewController(ColorViewModel(UIColor.blueColor()), path: path)
    }

}
