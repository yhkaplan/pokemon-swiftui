//
//  PokeStore.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Foundation
import Combine
import SwiftUI

final class PokeStore: BindableObject {

    let willChange = PassthroughSubject<Void, Never>()
    var cancellable: AnyCancellable?

    var pokemons: [Pokemon] = [] {
        willSet {
            DispatchQueue.main.async { [weak self] in
                self?.willChange.send()
            }
        }
    }

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
                self?.pokemons.append(pokemon)
            }
        )
    }

}
