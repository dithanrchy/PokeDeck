//
//  Pokemon.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable, Equatable {
    let id: Int
    let height: Int
    let weight: Int
    let name: String
    let species: Species
    let sprites: Sprites
    let stats: [Stat]

    enum CodingKeys: String, CodingKey {
        case id, height, weight
        case name
        case species,sprites, stats
    }
}
