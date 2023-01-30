//
//  PokeEvolutionRepository.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxSwift

class PokeEvolutionRepository {
    let remoteDataSource = RemoteDataSource()

    func getPokemonDetail(name: String) -> Observable<Pokemon> {
        return remoteDataSource.getPokemonDetail(name: name)
    }
}
