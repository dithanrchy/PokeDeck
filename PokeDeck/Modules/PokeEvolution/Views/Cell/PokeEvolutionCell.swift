//
//  PokeEvolutionCell.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 24/01/23.
//

import UIKit
import SDWebImage
import RxSwift

class PokeEvolutionCell: UITableViewCell {

    @IBOutlet weak var preEvolutionImg: UIImageView!
    @IBOutlet weak var preEvolutionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var evolutionImg: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!

    let disposeBag = DisposeBag()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(pokemonViewModel: PokeEvolutionViewModel, currentEvolution: (species: String, minLevel: Int), nextEvolution: (species: String, minLevel: Int)? = nil) {
        preEvolutionLabel.text = currentEvolution.species
        levelLabel.text = "Lv.\(nextEvolution?.minLevel ?? 0)"
        evolutionLabel.text = nextEvolution?.species

        configureImage(pokemonViewModel: pokemonViewModel, currentEvolutionName: currentEvolution.species, nextEvolutionName: nextEvolution?.species ?? "")
    }

    func configureImage(pokemonViewModel: PokeEvolutionViewModel, currentEvolutionName: String, nextEvolutionName: String) {
        pokemonViewModel.getPokemonDetail(name: currentEvolutionName).observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.preEvolutionImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.preEvolutionImg.sd_setImage(
                    with: URL(string: result.sprites.frontDefault),
                    placeholderImage: UIImage(named: "pokeapi_bw"),
                    options: .progressiveLoad,
                    completed: nil
                )
            })
            .disposed(by: disposeBag)

        pokemonViewModel.getPokemonDetail(name: nextEvolutionName).observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.evolutionImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.evolutionImg.sd_setImage(
                    with: URL(string: result.sprites.frontDefault),
                    placeholderImage: UIImage(named: "pokeapi_bw"),
                    options: .progressiveLoad,
                    completed: nil
                )
            })
            .disposed(by: disposeBag)
    }
}
