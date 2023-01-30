//
//  Other+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension Other {
    func toEntity(context: NSManagedObjectContext) -> OtherEntity {
        let other = OtherEntity(context: context)
        other.dreamWorld = dreamWorld.toEntity(context: context)

        return other
    }
}
