//
//  Pokemon+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension Pokemon {
    func toEntity(context: NSManagedObjectContext) -> PokemonEntity {
        let pokemon = PokemonEntity(context: context)
        pokemon.id = Int64(id)
        pokemon.name = name
        pokemon.weight = Int32(weight)
        pokemon.height = Int32(height)

        pokemon.species = species.toEntity(context: context)
        pokemon.sprites = sprites.toEntity(context: context)
        pokemon.stats = stats.map({ $0.toEntity(context: context) }).toNSOrderedSet()

        return pokemon
    }
}
