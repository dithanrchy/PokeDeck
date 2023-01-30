//
//  DetailedStatEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension DetailedStatEntity {
    func toDomain() -> DetailedStat {
        return DetailedStat(name: name ?? "",
                            url: url ?? "")
    }
}
