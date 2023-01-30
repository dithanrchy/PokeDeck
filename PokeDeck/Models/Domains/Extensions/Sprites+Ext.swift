//
//  Sprites+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import CoreData

extension Sprites {
    func toEntity(context: NSManagedObjectContext) -> SpritesEntity {
        let sprites = SpritesEntity(context: context)
        sprites.frontDefault = frontDefault
        sprites.other = other?.toEntity(context: context)

        return sprites
    }
}
