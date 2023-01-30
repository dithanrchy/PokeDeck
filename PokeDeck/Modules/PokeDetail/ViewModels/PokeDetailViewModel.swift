//
//  PokeDetailViewModel.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class PokeDetailViewModel {
    private let repository = PokeDetailRepository()

    func getPokemonSpeciesObservable(name: String) -> Observable<Evolution> {
        return repository.getPokemonEvolution(name: name)
    }
}
