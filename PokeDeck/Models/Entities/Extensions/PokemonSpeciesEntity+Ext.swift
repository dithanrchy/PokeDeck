//
//  PokemonSpeciesEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension PokemonSpeciesEntity {
    func toDomain() -> PokemonSpecies {
        return PokemonSpecies(name: name ?? "",
                              evolutionChain: evolutionChain!.toDomain())
    }
}
