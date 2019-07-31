//
//  Pokemon.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Foundation

public struct PokemonPage: Codable {
    public let count: Int
    public let previousPage: URL?
    public let nextPage: URL?
    public let pokemons: [Pokemon]

    enum CodingKeys: String, CodingKey {
    case count
    case previousPage = "previous"
    case nextPage = "next"
    case pokemons = "results"
    }
}

public struct Pokemon: Codable {
    public let height: Int?
    public let id: Int?
    public let name: String
    public let url: URL?
}
