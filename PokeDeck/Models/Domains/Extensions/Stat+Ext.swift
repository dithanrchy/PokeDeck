//
//  Stat+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension Stat {
    func toEntity(context: NSManagedObjectContext) -> StatEntity {
        let stats = StatEntity(context: context)
        stats.baseStat = Int32(baseStat)
        stats.effort = Int32(effort)
        stats.stat = stat.toEntity(context: context)

        return stats
    }
}
