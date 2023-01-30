// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonSpecies = try? newJSONDecoder().decode(PokemonSpecies.self, from: jsonData)

import Foundation

// MARK: - PokemonSpecies
struct PokemonSpecies: Codable, Equatable {
    let name: String
    let evolutionChain: EvolutionChain

    enum CodingKeys: String, CodingKey {
        case name
        case evolutionChain = "evolution_chain"
    }
}
