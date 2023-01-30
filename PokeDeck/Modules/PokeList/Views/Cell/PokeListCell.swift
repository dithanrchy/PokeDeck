//
//  PokeListCell.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import UIKit
import SDWebImage

class PokeListCell: UITableViewCell {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(name: String, urlImage: String){
        pokemonName.text = name.capitalizingFirstLetter()
        pokemonImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        pokemonImg.sd_setImage(
            with: URL(string: urlImage),
            placeholderImage: UIImage(named: "pokeapi_bw"),
            options: .progressiveLoad,
            completed: nil
        )
    }

}
