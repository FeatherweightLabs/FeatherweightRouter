//
//  Regex.swift
//  Beeline
//
//  Created by Karl Bowden on 4/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import Foundation

// Source: https://gist.github.com/mattt/3f12f56d72b8d2ebbe62

struct Regex {
    let pattern: String
    let options: NSRegularExpressionOptions

    private var matcher: NSRegularExpression {
        return try! NSRegularExpression(pattern: pattern, options: options)
    }

    init(pattern: String, options: NSRegularExpressionOptions = .AnchorsMatchLines) {
        self.pattern = pattern
        self.options = options
    }

    func matches(string: String, options: NSMatchingOptions = []) -> [String] {
        let nsString = string as NSString
        let results = matcher.matchesInString(string, options: options, range: NSMakeRange(0, nsString.length))
        return results.map { nsString.substringWithRange($0.range)}
    }

    func match(string: String, options: NSMatchingOptions = []) -> String? {
        return matches(string, options: options).first
    }

    func replace(string: String, replacement: String = "", options: NSMatchingOptions = .Anchored) -> String? {
        guard let range = string.rangeOfString(pattern, options: .RegularExpressionSearch) else { return nil }
        return string.stringByReplacingCharactersInRange(range, withString: replacement)
    }

}
