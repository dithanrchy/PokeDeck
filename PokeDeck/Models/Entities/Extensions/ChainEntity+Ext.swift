//
//  ChainEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension ChainEntity {
    func toDomain() -> Chain {
        return Chain (
            evolutionDetails: evolutionDetails?.toArray(of: EvolutionDetailEntity.self).map { $0.toDomain() } ?? [],
            evolvesTo: evolvesTo?.toArray(of: ChainEntity.self).map { $0.toDomain() } ?? [],
            species: species!.toDomain()
            )
    }
}
