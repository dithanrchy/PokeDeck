//
//  PokeDetailRepository.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxCocoa
import RxSwift

class PokeDetailRepository {
    let remoteDataSource = RemoteDataSource()
    let localeDataSource = PokeDetailLocaleDataSource.shared

    func getPokemonSpecies(name: String) -> Observable<PokemonSpecies> {
        return remoteDataSource.getPokemonSpecies(name: name)
    }

    func getEvolution(url: String) -> Observable<Evolution> {
        return remoteDataSource.getEvolution(url: url)
    }

    func getPokemonEvolution(name: String) -> Observable<Evolution> {
        let local = getLocaleEvolution(name: name)
        let remote = getRemoteEvolution(name: name)
        let value = Observable.merge(local, remote)

        return value
    }

    func getLocaleEvolution(name: String) -> Observable<Evolution> {
        return localeDataSource.getPokemonSpecies(name: name)
            .flatMap {
                self.localeDataSource.getEvolution(url: $0?.evolutionChain?.url ?? "")
            }
            .map { $0.toDomain() }
    }

    func getRemoteEvolution(name: String) -> Observable<Evolution> {
        return getPokemonSpecies(name: name)
            .flatMap {
                self.updatePokemonSpecies(name: name, pokemonSpecies: $0)
            }
            .filter { $0 }
            .flatMap { _ in
                self.localeDataSource.getPokemonSpecies(name: name)
            }
            .flatMap { species in
                self.getEvolution(url: species?.evolutionChain?.url ?? "" )
                    .map { (species, $0) }
            }
            .flatMap { species, evolution in
                self.updateEvolution(url: species?.evolutionChain?.url ?? "", evolution: evolution)
            }
            .filter { $0 }
            .flatMap { _ in
                self.getLocaleEvolution(name: name)
            }
    }

    func updatePokemonSpecies(name: String, pokemonSpecies: PokemonSpecies) -> Observable<Bool> {
        return localeDataSource.deletePokemonSpecies(name: name)
            .flatMap { _ in
                self.localeDataSource.savePokemonSpecies(pokemonSpecies: pokemonSpecies)
            }
    }

    func updateEvolution(url: String, evolution: Evolution) -> Observable<Bool> {
        return localeDataSource.deleteEvolution(url: url)
            .flatMap { _ in
                self.localeDataSource.saveEvolution(url: url, evolution: evolution)
            }
    }
}
