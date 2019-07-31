//
//  PokeStore.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Foundation
import Combine
import SwiftUI

public final class PokeStore: ObservableObject {

    var cancellable: AnyCancellable?

    @Published public var pokemons: [Pokemon] = []
    @Published public var majorErrorDidOccur = false // TODO: what is best way to share error w/

    public init() {
        downloadPokemons()
    }

    public func cancel() {
        cancellable?.cancel()
    }

    public func downloadPokemons() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // TODO: this probably erases useful info like empty data and response code...
            .decode(type: PokemonPage.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure(let error):
                    if error is URLError {
                        DispatchQueue.main.async {
                            self?.majorErrorDidOccur = true
                        }
                    }
                    print("Error: " + error.localizedDescription)
                case .finished:
                    print("Success!")
                }
            }, receiveValue: { [weak self] pokemonPage in
                // TODO: Another approach preferred?
                // Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
                DispatchQueue.main.async {
                    self?.pokemons.append(contentsOf: pokemonPage.pokemons)
                }

            }
        )
    }

}
