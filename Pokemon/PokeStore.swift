//
//  PokeStore.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Foundation
import Combine
import SwiftUI

final class PokeStore: ObservableObject {

    var cancellable: AnyCancellable?

    @Published var pokemons: [Pokemon] = []

    init() {
        downloadPokemon()
    }

    func downloadPokemon() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // TODO: this probably erases errors
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                // TODO: do something w/ error?
            }, receiveValue: { [weak self] pokemon in
                // TODO: Another approach preferred?
                // Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
                DispatchQueue.main.async {
                    self?.pokemons.append(pokemon)
                }

            }
        )
    }

}
