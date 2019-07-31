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
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // TODO: this probably erases useful info like empty data and response code...
            .decode(type: PokemonPage.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
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
