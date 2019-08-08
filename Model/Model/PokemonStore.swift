//
//  PokemonStore.swift
//  Model
//
//  Created by josh on 2019/08/06.
//  Copyright © 2019 josh. All rights reserved.
//

import Combine
import SwiftUI

public extension Result {
    var value: Success? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
    var error: Failure? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}

public final class Store<Value: Decodable>: ObservableObject {

    public typealias DownloadPublisher = AnyPublisher<Value, Error>

    private var cancellable: AnyCancellable?
    private let publisher: DownloadPublisher

    @Published public var result: Result<Value, Error>

    public init(initialValue: Value, publisher: DownloadPublisher) {
        self.result = .success(initialValue)
        self.publisher = publisher
    }

    public func download(_ url: URL) {
        cancellable = publisher
            .sink(receiveCompletion: { [weak self] error in
                DispatchQueue.main.async {
//                    self?.result = .failure(error) build erro
                }
            }, receiveValue: { [weak self] value in
                DispatchQueue.main.async {
                    self?.result = .success(value)
                }
            })
    }

    public func cancel() {
        cancellable?.cancel()
    }
}



public final class PokemonStore: ObservableObject {

    var cancellable: AnyCancellable?

    @Published public var pokemon: Pokemon
    @Published public var majorErrorDidOccur = false // TODO: what is best way to share error w/

    public init(pokemon: Pokemon) {
        self.pokemon = pokemon

        guard let url = pokemon.url else { return }
        downloadPokemonDetails(url: url)
    }

    public func cancel() {
        cancellable?.cancel()
    }

    // Reference: https://medium.com/@dmytro.anokhin/url-image-view-in-swiftui-f08f85d942d8
    func downloadSpriteImages() { fatalError() }

    func downloadPokemonDetails(url: URL) {
        cancellable = PublisherProvider.publisher(for: Pokemon.self, url: url)
            .sink(receiveCompletion: { result in

            }, receiveValue: { [weak self] pokemon in
                DispatchQueue.main.async {
                    self?.pokemon = pokemon
                }
            })
    }

}
