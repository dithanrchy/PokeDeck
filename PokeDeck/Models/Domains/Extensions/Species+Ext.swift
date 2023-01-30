//
//  Species+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension Species {
    func toEntity(context: NSManagedObjectContext) -> SpeciesEntity {
        let species = SpeciesEntity(context: context)
        species.name = name
        species.url = url

        return species
    }
}
