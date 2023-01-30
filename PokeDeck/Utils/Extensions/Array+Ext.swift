//
//  Array+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension Array {
    func toNSOrderedSet() -> NSOrderedSet {
        return NSOrderedSet(array: self)
    }
}
