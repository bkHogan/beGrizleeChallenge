//
//  FeedServiceType.swift
//  BrianKeithChallenge
//
//  Created by Brian Hogan on 12/17/21.
//

import Foundation
import Combine

protocol FeedServiceType {
    var networkManager: NetworkManagerType { get }
    var decoder: JSONDecoder { get }
    func getFeeds(from urlS: String) -> AnyPublisher<Response, Error>
    func getImage(from urlS: String) -> AnyPublisher<Data, Error>
}
