//
//  AppStore.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

class AppStore: ProvidesRouteDispatch {

    var setPath: String -> Void!

    init(setPath: String -> Void) {
        self.setPath = setPath
    }

    func dispatchRoute(string: String) {
        setPath(string)
    }

}
