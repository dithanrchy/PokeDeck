//
//  PokeDetailLocaleDataSource.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 26/01/23.
//

import Foundation
import RxSwift

class PokeDetailLocaleDataSource {
    private let context = PersistenceController.shared.container.viewContext

    static let shared = PokeDetailLocaleDataSource()

    func getPokemonSpecies(name: String) -> Observable<PokemonSpeciesEntity?> {
        return Observable<PokemonSpeciesEntity?>.create { observer in
            do {
                let request = PokemonSpeciesEntity.fetchRequest()
                request.predicate = NSPredicate(format: "%K == %@", #keyPath(PokemonSpeciesEntity.name), name)
                if let pokemonSpecies = try self.context.fetch(request).first {
                    print("data species exist")
                    observer.onNext(pokemonSpecies)
                    observer.onCompleted()
                }
                else {
                    observer.onCompleted()
                    print("data species not exist")
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func getEvolution(url: String) -> Observable<EvolutionEntity> {
        return Observable<EvolutionEntity>.create { observer in
            do {
                let request = EvolutionEntity.fetchRequest()
                request.predicate = NSPredicate(format: "%K == %@", #keyPath(EvolutionEntity.url), url)
                if let evolution = try self.context.fetch(request).first {
                    print("data evo exist")
                    observer.onNext(evolution)
                    observer.onCompleted()
                }
                else {
                    observer.onCompleted()
                    print("data evo not exist")
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func savePokemonSpecies(pokemonSpecies: PokemonSpecies) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                let _ = pokemonSpecies.toEntity(context: self.context)
                try self.context.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func saveEvolution(url: String, evolution: Evolution) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                let _ = evolution.toEntity(url: url, context: self.context)
                try self.context.save()
                let request = EvolutionEntity.fetchRequest()
                request.predicate = NSPredicate(format: "%K == %@", #keyPath(EvolutionEntity.url), url)
                let evolution = try self.context.fetch(request)
                print(evolution.map { $0.chain?.evolvesTo?.toArray(of: ChainEntity.self).map { $0.species?.name }})
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func deletePokemonSpecies(name: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                let request = PokemonSpeciesEntity.fetchRequest()
                request.predicate = NSPredicate(format: "name = %@", #keyPath(PokemonSpeciesEntity.name), name)
                if let pokemon = try self.context.fetch(request).first {
                    self.context.delete(pokemon)
                    try self.context.save()
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func deleteEvolution(url: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                let request = EvolutionEntity.fetchRequest()
                request.predicate = NSPredicate(format: "url = %@", #keyPath(EvolutionEntity.url), url)
                if let pokemon = try self.context.fetch(request).first {
                    self.context.delete(pokemon)
                    try self.context.save()
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
