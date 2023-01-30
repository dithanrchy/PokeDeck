//
//  PokemonIndex.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - PokemonIndex
struct PokemonIndex: Codable, Equatable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [DetailedPokemon]
}
