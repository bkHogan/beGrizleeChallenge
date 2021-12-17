//
//  Constants.swift
//  BrianKeithChallenge
//
//  Created by Brian Hogan on 12/17/21.
//

import Foundation

enum URLs {
    static let urlBase = "https://www.reddit.com/.json"
    static let keyAfter = "$AFTER_KEY"
    static let redditFeedURL = "\(urlBase)?after=\(keyAfter)"
}

enum CustomSpaces {
    static let spacingBetweenViews = 10.0
}
