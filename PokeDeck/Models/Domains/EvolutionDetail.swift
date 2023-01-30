//
//  EvolutionDetail.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable, Equatable {
    let minLevel: Int?

    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
    }
}
