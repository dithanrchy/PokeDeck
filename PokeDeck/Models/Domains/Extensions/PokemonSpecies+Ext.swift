//
//  PokemonSpecies+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension PokemonSpecies {
    func toEntity(context: NSManagedObjectContext) -> PokemonSpeciesEntity {
        let pokemonSpecies = PokemonSpeciesEntity(context: context)
        pokemonSpecies.name = name
        pokemonSpecies.evolutionChain = evolutionChain.toEntity(context: context)
        
        return pokemonSpecies
    }
}
