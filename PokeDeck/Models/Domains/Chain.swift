//
//  Chain.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - Chain
struct Chain: Codable, Equatable {
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [Chain]
    let species: Species

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case species
    }
}
