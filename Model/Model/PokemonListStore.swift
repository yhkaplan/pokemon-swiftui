//
//  PokeStore.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Combine
import SwiftUI

public enum Message {
    case reload
    case receiveObject([Pokemon])
}

public enum Output {
    case load(URL, completion: (Data) -> Message)
}

public func pokemonReducer(action: @escaping (DownloadPokemonAction) -> Void, completion: @escaping ([Pokemon]?, Error?) -> Void) {
    action { result in // TODO: make this more generic
        switch result {
        case .success(let newPokemon):
            completion(newPokemon, nil)
        case .failure(let newError):
            completion(nil, newError)
        }
    }
}

public enum PokeError: Error {
    case noData
}

public typealias DownloadPokemonAction = (Result<[Pokemon], Error>) -> Void

public func downloadPokemons(completion: @escaping DownloadPokemonAction) {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(PokeError.noData))
            return
        }

        do {
            let pokemonPage = try JSONDecoder().decode(PokemonPage.self, from: data)
            completion(.success(pokemonPage.pokemons))

        } catch {
            completion(.failure(error))
        }
    }.resume()
}

public typealias PokemonListStore = Store<PokemonPage>
// TODO: change Action from Void to download action
//public final class PokemonListStore: ObservableObject {
//
//    var cancellable: AnyCancellable?
//
//    @Published public var pokemons: [Pokemon] = []
//    @Published public var majorErrorDidOccur = false // TODO: what is best way to share error w/
//
//    public init() {
//        downloadPokemons()
//    }
//
//    public func cancel() {
//        cancellable?.cancel()
//    }
//
//    public func downloadPokemons() {
//        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
//        cancellable = PublisherProvider.publisher(for: PokemonPage.self, url: url)
//            .sink(receiveCompletion: { [weak self] result in
//                switch result {
//                case .failure(let error):
//                    if error is URLError {
//                        DispatchQueue.main.async {
//                            self?.majorErrorDidOccur = true
//                        }
//                    }
//                    print("Error: " + error.localizedDescription)
//                case .finished:
//                    print("Success!")
//                }
//            }, receiveValue: { [weak self] pokemonPage in
//                // TODO: Another approach preferred?
//                // Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
//                DispatchQueue.main.async {
//                    self?.pokemons.append(contentsOf: pokemonPage.pokemons)
//                }
//
//            }
//        )
//    }
//
//}
