//
//  NSOrderedSet+Ext.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation

extension NSOrderedSet {
    func toArray<T>(of: T.Type = T.self) -> [T] {
        var array = [T]()
        for item in self {
            if let item = item as? T {
                array.append(item)
            }
        }
        return array
    }
}
