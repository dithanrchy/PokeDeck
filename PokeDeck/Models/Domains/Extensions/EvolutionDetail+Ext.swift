//
//  EvolutionDetail+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 26/01/23.
//

import Foundation
import CoreData

extension EvolutionDetail {
    func toEntity(context: NSManagedObjectContext) -> EvolutionDetailEntity {
        let evolutionDetail = EvolutionDetailEntity(context: context)
        evolutionDetail.minLevel = Int32(minLevel ?? 0)

        return evolutionDetail
    }
}
