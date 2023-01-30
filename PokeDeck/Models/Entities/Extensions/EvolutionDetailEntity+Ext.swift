//
//  EvolutionDetailEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension EvolutionDetailEntity {
    func toDomain() -> EvolutionDetail {
        return EvolutionDetail(minLevel: Int(minLevel))
    }
}
