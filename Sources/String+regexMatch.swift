//
//  String+regexMatch.swift
//  FeatherweightRouter
//
//  Created by Karl Bowden on 28/01/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import Foundation

extension String {

    /**
     Using Self as a regex, check if a given string is a match.

     - parameter string: String to check is Regex(Self) is a match for.

     - returns: Bool, true if String is a match
     */
    func regexMatch(string: String) -> Bool {
        guard let regex = try? NSRegularExpression(
            pattern: self, options: .AnchorsMatchLines) else { return false }

        let range = NSRange(location: 0, length: (string as NSString).length)
        return regex.matchesInString(string, options: [], range: range).count != 0
    }

}
