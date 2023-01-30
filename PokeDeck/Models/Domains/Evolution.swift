//
//  Evolution.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - Evolution
struct Evolution: Codable, Equatable {
    let chain: Chain
    let id: Int

    enum CodingKeys: String, CodingKey {
        case chain, id
    }
}
