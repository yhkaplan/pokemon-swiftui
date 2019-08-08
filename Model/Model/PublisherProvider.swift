//
//  PublisherProvider.swift
//  Model
//
//  Created by josh on 2019/08/06.
//  Copyright © 2019 josh. All rights reserved.
//

import Foundation
import Combine

public enum PublisherProvider {

    public static func publisher<D: Decodable>(for type: D.Type, url: URL) ->  AnyPublisher<D, Error> /*Publishers.Decode<Publishers.Map<URLSession.DataTaskPublisher, JSONDecoder.Input>, D, JSONDecoder>*/ {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: D.self, decoder: decoder)
            .eraseToAnyPublisher()
            // TODO: use .eraseToAnyPublisher() to make return type simpler !!!
    }
}
