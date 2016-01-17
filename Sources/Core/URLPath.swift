//
//  URLPath.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import Foundation

public struct URLPath: Path, Equatable {

    public let path: String

    public let pattern: String

    public let query: String

    public init(_ rawPath: String) {
        let url = NSURL(string: rawPath)
        let trimChars = NSCharacterSet(charactersInString: "/")
        path = (url?.path ?? "").stringByTrimmingCharactersInSet(trimChars)
        query = url?.query ?? ""
        pattern = ""
    }

    public func mutate(path path: String? = nil, query: String? = nil, pattern: String? = nil) -> Path {
        return URLPath(path: path ?? self.path, query: query ?? self.query, pattern: pattern ?? self.pattern)
    }

    private init(path: String, query: String, pattern: String = "") {
        self.path = path
        self.query = query
        self.pattern = pattern
    }
}
