//
//  EvolutionChain+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension EvolutionChain {
    func toEntity(context: NSManagedObjectContext) -> EvolutionChainEntity {
        let evolutionChain = EvolutionChainEntity(context: context)
        evolutionChain.url = url

        return evolutionChain
    }
}

