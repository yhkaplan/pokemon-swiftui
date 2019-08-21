//
//  Endpoints.swift
//  Model
//
//  Created by josh on 2019/08/21.
//  Copyright © 2019 josh. All rights reserved.
//

import Foundation
import TinyNetworking

let defaultDecoder: JSONDecoder = {
    let d = JSONDecoder()
    d.keyDecodingStrategy = .convertFromSnakeCase
    return d
}()

public let pokemonPageEndpoint: Endpoint<PokemonPage> = Endpoint(
    json: .get,
    url: URL(string: "https://pokeapi.co/api/v2/pokemon/")!,
    decoder: defaultDecoder
)

public func pokemonEndpoint(pokemon: Pokemon) -> Endpoint<Pokemon> {
    Endpoint(
        json: .get,
        url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)/")!,
        decoder: defaultDecoder
    )
}
