//
//  PokeListViewModel.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 25/01/23.
//

import Foundation
import RxCocoa
import RxSwift

class PokeListViewModel {
    private let repository = PokeListRepository()
    let urlObservable = BehaviorSubject<String?>(value: nil)
    var data = PokemonResponse(count: 0, results: [])
    let isLoading = BehaviorSubject<Bool>(value: false)

    func getPokemonListObservable() -> Observable<[Pokemon]> {
        isLoading.onNext(true)
        return urlObservable.flatMap { [unowned self] url in
            self.repository.getPokemonList(url: url)
                .map { pokemon in
                    self.data.next = pokemon.next
                    self.data.previous = pokemon.previous
                    if url != nil {
                        self.data.results.append(contentsOf: pokemon.results)
                    } else {
                        self.data.results = pokemon.results
                    }
                    return self.data.results
                }
        }
        .do(onNext: { _ in
            self.isLoading.onNext(false)
        }, onError: { _ in
            self.isLoading.onNext(false)
        })
    }

    func loadNext() {
        if let url = data.next, (try? !isLoading.value()) != nil {
            isLoading.onNext(true)
            urlObservable.onNext(url)
        }
    }

    func refresh() {
        isLoading.onNext(true)
        urlObservable.onNext(nil)
        data.next = nil
        data.previous = nil
    }
}
