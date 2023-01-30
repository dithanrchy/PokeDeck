//
//  PokeListRepository.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxSwift

class PokeListRepository {
    let remoteDataSource = RemoteDataSource()
    let localeDataSource = PokeListLocaleDataSource.shared

    func getDetailedPokemonList(url: String? = nil) -> Observable<PokemonIndex> {
        return remoteDataSource.getPokemonList(url: url)
    }

    func getPokemonDetail(name: String) -> Observable<Pokemon> {
        return remoteDataSource.getPokemonDetail(name: name)
    }

    func getPokemonList(url: String? = nil) -> Observable<PokemonResponse> {
        if let url = url {
            return getRemotePokemonList(url: url)
        }

        let local = getLocalePokemonList()
            .map { PokemonResponse(count: $0.count, next: nil, previous: nil, results: $0)}
        let remote = getRemotePokemonList()
            .flatMap { pokemon in
                return self.updatePokemonList(pokemons: pokemon.results)
                    .map { _ in pokemon }
            }
        let value = Observable.merge(local, remote)

        return value
    }

    private func getLocalePokemonList() -> Observable<[Pokemon]> {
        return localeDataSource.get()
            .map { $0.map {
                $0.toDomain()
            }}
            .filter({
                !$0.isEmpty
            })
    }

    private func getRemotePokemonList(url: String? = nil) -> Observable<PokemonResponse> {
        return getDetailedPokemonList(url: url)
            .map { ($0, $0.results.map { self.getPokemonDetail(name: $0.name) }) }
            .flatMap { pokemon in
                Observable.zip(pokemon.1).map { (pokemon.0, $0) }
            }
            .map { pokemonResponse, pokemonDetail in
                PokemonResponse(count: pokemonResponse.count, next: pokemonResponse.next, previous: pokemonResponse.previous, results: pokemonDetail)
            }
    }

    private func updatePokemonList(pokemons: [Pokemon]) -> Observable<Bool> {
        return localeDataSource.delete()
            .flatMap { _ in
                self.localeDataSource.save(pokemons: pokemons)
            }
    }
}
