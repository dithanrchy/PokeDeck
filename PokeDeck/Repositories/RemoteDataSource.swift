//
//  RemoteDataSource.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import Foundation
import Alamofire
import RxSwift

class RemoteDataSource {
    func getPokemonList(url: String? = nil) -> Observable<PokemonIndex> {
        return Observable<PokemonIndex>.create { observer in
            if let getUrl = URL(string: url ?? "https://pokeapi.co/api/v2/pokemon") {
                AF.request(getUrl).validate().responseDecodable(of: PokemonIndex.self) { response in
                    switch response.result {
                    case let .success(value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case let .failure(error):
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }

    func getPokemonDetail(name: String) -> Observable<Pokemon> {
        return Observable<Pokemon>.create { observer in
            if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") {
                AF.request(url).validate().responseDecodable(of: Pokemon.self) { response in
                    switch response.result {
                    case let .success(value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case let .failure(error):
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }

    func getPokemonSpecies(name: String) -> Observable<PokemonSpecies> {
        return Observable<PokemonSpecies>.create { observer in
            if let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(name)") {
                AF.request(url).validate().responseDecodable(of: PokemonSpecies.self) { response in
                    switch response.result {
                    case let .success(value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case let .failure(error):
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }


    func getEvolution(url: String) -> Observable<Evolution> {
        return Observable<Evolution>.create { observer in
            AF.request(url).validate().responseDecodable(of: Evolution.self) { response in
                switch response.result {
                case let .success(value):
                    observer.onNext(value)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
