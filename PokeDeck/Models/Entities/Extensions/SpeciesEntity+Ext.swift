//
//  SpeciesEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension SpeciesEntity {
    func toDomain() -> Species {
        return Species(name: name ?? "",
                       url: url ?? "")
    }
}
