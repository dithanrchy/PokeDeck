//
//  SpritesEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension SpritesEntity {
    func toDomain() -> Sprites {
        return Sprites(frontDefault: frontDefault ?? "",
                       other: other?.toDomain())
    }
}
