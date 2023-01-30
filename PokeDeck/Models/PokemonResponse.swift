//
//  PokemonResponse.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 29/01/23.
//

import Foundation

struct PokemonResponse {
    var count: Int
    var next: String? = nil
    var previous: String? = nil
    var results: [Pokemon]
}
