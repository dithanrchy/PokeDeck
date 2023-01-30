//
//  PokeEvolutionViewController.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 23/01/23.
//

import UIKit
import RxSwift

class PokeEvolutionViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    var evolutionData = [PokeEvolution]()
    var pokemonChain: Evolution?

    let pokemonViewModel = PokeEvolutionViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokeEvolutionCell", bundle: nil), forCellReuseIdentifier: "pokeEvolutionCell")

        guard let pokemonChain = pokemonChain else { return }
        gatherEvolutionData(pokemonChain.chain, previousSpeciesName: nil)
        tableView.reloadData()
    }

    func gatherEvolutionData(_ chain: Chain, previousSpeciesName: String?) {
        for nextChain in chain.evolvesTo {
            gatherEvolutionData(nextChain, previousSpeciesName: chain.species.name)
        }
        if let previousSpeciesName = previousSpeciesName {
            let species = chain.species.name
            let minLevel = chain.evolutionDetails.first?.minLevel ?? 0

            evolutionData.insert(PokeEvolution(currentEvolution: (species: species, minLevel: minLevel),
                                               nextEvolution: (species: previousSpeciesName, minLevel: minLevel)), at: 0)
        }
    }
}

extension PokeEvolutionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeEvolutionCell", for: indexPath) as? PokeEvolutionCell

        let evolution = evolutionData[indexPath.row]
        if let nextEvolution = evolution.nextEvolution {
            cell?.configure(pokemonViewModel: pokemonViewModel, currentEvolution: nextEvolution, nextEvolution: evolution.currentEvolution)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evolutionData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}


struct PokeEvolution {
    var currentEvolution: (species: String, minLevel: Int)
    var nextEvolution: (species: String, minLevel: Int)?
}
