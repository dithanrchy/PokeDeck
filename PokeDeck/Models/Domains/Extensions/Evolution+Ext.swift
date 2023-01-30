//
//  Evolution+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension Evolution {
    func toEntity(url: String, context: NSManagedObjectContext) -> EvolutionEntity {
        let evolution = EvolutionEntity(context: context)
        evolution.id = Int64(id)
        evolution.chain = chain.toEntity(context: context)
        evolution.url = url

        return evolution
    }
}
