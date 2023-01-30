//
//  DreamWorld+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension DreamWorld {
    func toEntity(context: NSManagedObjectContext) -> DreamWorldEntity {
        let dreamWorld = DreamWorldEntity(context: context)
        dreamWorld.frontDefault = frontDefault

        return dreamWorld
    }
}
