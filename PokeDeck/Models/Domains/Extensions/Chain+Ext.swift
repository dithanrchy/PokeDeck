//
//  Chain+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 26/01/23.
//

import Foundation
import CoreData

extension Chain {
    func toEntity(context: NSManagedObjectContext) -> ChainEntity {
        let chain = ChainEntity(context: context)
        chain.species = species.toEntity(context: context)
        chain.evolvesTo = evolvesTo.map({ $0.toEntity(context: context) }).toNSOrderedSet()
        chain.evolutionDetails = evolutionDetails.map({ $0.toEntity(context: context) }).toNSOrderedSet()

        return chain
    }
}
