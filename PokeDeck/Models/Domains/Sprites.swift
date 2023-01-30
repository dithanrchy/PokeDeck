//
//  Sprites.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation


// MARK: - Sprites
struct Sprites: Codable, Equatable {
    let frontDefault: String
    let other: Other?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}
