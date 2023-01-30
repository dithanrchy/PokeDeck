//
//  DetailedStat+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension DetailedStat {
    func toEntity(context: NSManagedObjectContext) -> DetailedStatEntity {
        let detailedStat = DetailedStatEntity(context: context)
        detailedStat.name = name
        detailedStat.url = url

        return detailedStat
    }
}
