//
//  Other.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - Other
struct Other: Codable, Equatable {
    let dreamWorld: DreamWorld

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
    }
}
