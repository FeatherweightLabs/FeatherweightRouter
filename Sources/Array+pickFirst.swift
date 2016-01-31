//
//  Array+pickFirst.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 28/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

extension Array {

    func pickFirst<T>(predicate: Element -> T?) -> T? {
        for item in self {
            if let result = predicate(item) {
                return result
            }
        }
        return nil
    }

}
