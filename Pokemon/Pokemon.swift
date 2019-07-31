//
//  Pokemon.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let previousPage: URL?
    let nextPage: URL?
    let pokemons: [Pokemon]

    enum CodingKeys: String, CodingKey {
    case count
    case previousPage = "previous"
    case nextPage = "next"
    case pokemons = "results"
    }
}

struct Pokemon: Codable {
    let height: Int?
    let id: Int?
    let name: String
    let url: URL?
}
