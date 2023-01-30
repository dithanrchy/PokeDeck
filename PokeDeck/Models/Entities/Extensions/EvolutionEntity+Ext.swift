//
//  EvolutionEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension EvolutionEntity {
    func toDomain() -> Evolution {
        return Evolution(chain: chain!.toDomain(),
                         id: Int(id))
    }
}
