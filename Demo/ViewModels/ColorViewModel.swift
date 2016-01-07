//
//  ColorViewModel.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

protocol ProvidesColor {
    var backgroundColor: UIColor { get }
}

struct ColorViewModel: ProvidesColor {

    let backgroundColor: UIColor

    init(_ backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}
