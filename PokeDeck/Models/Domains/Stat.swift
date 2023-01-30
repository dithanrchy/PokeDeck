//
//  Stat.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation

// MARK: - Stat
struct Stat: Codable, Equatable {
    let baseStat, effort: Int
    let stat: DetailedStat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
