//
//  AppStore.swift
//  Beeline
//
//  Created by Karl Bowden on 7/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

struct AppStore: ProvidesRouteDispatch {

    let setPath: String -> ()

    init(setPath: String -> ()) {
        self.setPath = setPath
    }

    func dispatchRoute(string: String) {
        setPath(string)
    }

}
