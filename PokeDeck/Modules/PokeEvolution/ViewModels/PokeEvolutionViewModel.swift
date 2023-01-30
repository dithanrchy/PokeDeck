//
//  PokeEvolutionViewModel.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class PokeEvolutionViewModel {
    private let repository = PokeEvolutionRepository()

    func getPokemonDetail(name: String) -> Observable<Pokemon> {
        return repository.getPokemonDetail(name: name)
    }
}
