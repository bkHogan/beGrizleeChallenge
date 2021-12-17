//
//  NetworkManagerType.swift
//  BrianKeithChallenge
//
//  Created by Brian Hogan on 12/17/21.
//

import Foundation
import Combine

protocol NetworkManagerType {
    func get(from url: URL) -> AnyPublisher<Data, Error>
}
