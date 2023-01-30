//
//  PokeListLocaleDataSource.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxSwift
import CoreData

class PokeListLocaleDataSource {
    private let context = PersistenceController.shared.container.viewContext

    static let shared = PokeListLocaleDataSource()

    func get() -> Observable<[PokemonEntity]> {
        return Observable<[PokemonEntity]>.create { observer in
            do {
                let sort = NSSortDescriptor(keyPath: \PokemonEntity.id, ascending: true)
                let request = PokemonEntity.fetchRequest()
                request.sortDescriptors = [sort]
                let pokemons = try self.context.fetch(request)
                observer.onNext(pokemons)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func save(pokemons: [Pokemon]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                pokemons.forEach{ let _ = $0.toEntity(context: self.context) }
                try self.context.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                let request = PokemonEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
                let batchDelete = NSBatchDeleteRequest(fetchRequest: request)
                try self.context.execute(batchDelete)
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
