//
//  DataResponse.swift
//  BrianKeithChallenge
//
//  Created by Brian Hogan on 12/17/21.
//

import Foundation

struct DataResponse: Decodable {
    let after: String
    let children: [DataFeed]
}
