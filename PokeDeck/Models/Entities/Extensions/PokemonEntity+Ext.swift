//
//  PokemonEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension PokemonEntity {
    func toDomain() -> Pokemon {
        return Pokemon(id: Int(id),
                       height: Int(height),
                       weight: Int(weight),
                       name: name ?? "",
                       species: species!.toDomain(),
                       sprites: sprites!.toDomain(),
                       stats: stats!.toArray(of: StatEntity.self).map { $0.toDomain() })
    }
}
