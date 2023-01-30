//
//  DreamWorldEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension DreamWorldEntity {
    func toDomain() -> DreamWorld {
        return DreamWorld(frontDefault: frontDefault ?? "")
    }
}
