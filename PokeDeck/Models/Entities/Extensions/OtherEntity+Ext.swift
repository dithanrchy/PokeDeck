//
//  OtherEntity+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension OtherEntity {
    func toDomain() -> Other {
        return Other(dreamWorld: dreamWorld!.toDomain())
    }
}
