//
//  PokeDeckTests.swift
//  PokeDeckTests
//
//  Created by Ditha Nurcahya Avianty on 30/01/23.
//

import RxSwift
import RxTest
import XCTest

@testable import PokeDeck
final class PokeDeckTests: XCTestCase {
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var pokeDetailRepository: PokeDetailRepository!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        pokeDetailRepository = PokeDetailRepository()
    }

    func testGetPokemonEvolution() {
        let expectedEvolution = Evolution(chain: Chain(evolutionDetails: [], evolvesTo: [Chain(evolutionDetails: [EvolutionDetail(minLevel: Optional(16))], evolvesTo: [Chain(evolutionDetails: [EvolutionDetail(minLevel: Optional(32))], evolvesTo: [], species: Species(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon-species/3/"))], species: Species(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon-species/2/"))], species: Species(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/")), id: 1)

        let evolutionObservable = pokeDetailRepository.getPokemonEvolution(name: "bulbasaur")
        let evolutionObserver = scheduler.createObserver(Evolution.self)

        scheduler.scheduleAt(100) {
            evolutionObservable.subscribe(evolutionObserver).disposed(by: self.disposeBag)
        }

        scheduler.start()
        
        XCTAssertEqual(evolutionObserver.events, [
            .next(100, expectedEvolution)
        ])
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
