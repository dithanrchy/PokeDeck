//
//  PokeStatViewController.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 23/01/23.
//

import UIKit
import LinearProgressBar

class PokeStatViewController: UIViewController {

    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenseValueLabel: UILabel!
    @IBOutlet weak var spAttackValueLabel: UILabel!
    @IBOutlet weak var spDefenseValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!

    @IBOutlet weak var hpProgressBar: LinearProgressBar!
    @IBOutlet weak var attackProgressBar: LinearProgressBar!
    @IBOutlet weak var defenseProgressBar: LinearProgressBar!
    @IBOutlet weak var spAttackProgressBar: LinearProgressBar!
    @IBOutlet weak var spDefenseProgressBar: LinearProgressBar!
    @IBOutlet weak var speedProgressBar: LinearProgressBar!

    var pokemonStats = [Stat]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupStatValue()
    }

    func setupStatValue() {
        let label = [hpValueLabel,
                     attackValueLabel,
                     defenseValueLabel,
                     spAttackValueLabel,
                     spDefenseValueLabel,
                     speedValueLabel]

        let progressBar = [hpProgressBar,
                           attackProgressBar,
                           defenseProgressBar,
                           spAttackProgressBar,
                           spDefenseProgressBar,
                           speedProgressBar]


        for i in 0...progressBar.count - 1 {
            progressBar[i]?.progressValue = CGFloat(pokemonStats[i].baseStat)
            label[i]?.text = String(pokemonStats[i].baseStat)
        }
    }
}
