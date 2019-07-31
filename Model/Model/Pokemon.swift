//
//  Pokemon.swift
//  Pokemon
//
//  Created by josh on 2019/07/17.
//

import Foundation

struct PokemonPage: Codable {
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

public struct Pokemon: Codable, Equatable {
    public let name: String

    public var url: URL?

    public var height: Int?
    public var id: Int?
    public var weight: Int?
    public var baseExperience: Int?
    public var sprites: Sprites?
}

public struct Sprites: Codable, Equatable {
    public var frontDefault: URL?
    public var backDefault: URL?
}

// TODO: Abilities, Forms, Moves, Species, Stats, Types
