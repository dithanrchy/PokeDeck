//
//  EvolutionChainEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension EvolutionChainEntity {
    func toDomain() -> EvolutionChain {
        return EvolutionChain(url: url ?? "")
    }
}
