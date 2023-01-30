//
//  StatEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension StatEntity {
    func toDomain() -> Stat {
        return Stat(baseStat: Int(baseStat),
                    effort: Int(effort),
                    stat: stat!.toDomain())
    }
}
