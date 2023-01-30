//
//  PokeDetailViewController.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class PokeDetailViewController: UIViewController {

    let customSegmentedControl: CustomSegmentedControl = {
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50), buttonTitle: ["Stats", "Evolution"])
        codeSegmented.backgroundColor = .clear
        return codeSegmented
    }()

    private lazy var pokemonImg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private let pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    var statVC: PokeStatViewController?
    var evolutionVC: PokeEvolutionViewController?
    var isFirstTimeOpenEvolution = true

    var pokemonDetail: Pokemon?

    private let pokemonDetailViewModel = PokeDetailViewModel()
    private let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
        guard let pokemonDetail = pokemonDetail, let urlImg = pokemonDetail.sprites.other?.dreamWorld.frontDefault else { return }

        setupStatVC(pokemonStats: pokemonDetail.stats)

        setupLayout()
        showEvolution(false)

        pokemonImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        pokemonImg.sd_setImage(
            with: URL(string: urlImg),
            placeholderImage: UIImage(named: "pokeapi_bw"),
            options: .progressiveLoad,
            completed: nil
        )

        pokemonName.text = pokemonDetail.name.capitalizingFirstLetter()

        pokemonDetailViewModel.getPokemonSpeciesObservable(name: pokemonDetail.name).observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.setupEvolutionVC(pokemonChain: result)
            },  onError: { error in
                self.showAlert(title: "No internet connection.", message: "Please check your connection and try again.", action: "OK")
            },  onCompleted: {
                
            })
            .disposed(by: disposeBag)



    }

    private func showEvolution(_ isShowing: Bool) {
        statVC?.view.isHidden = isShowing
        evolutionVC?.view?.isHidden = !isShowing
    }

    func setupStatVC(pokemonStats: [Stat]) {
        statVC = PokeStatViewController()
        statVC?.pokemonStats = pokemonStats
        addChild(statVC!)
    }

    func setupEvolutionVC(pokemonChain: Evolution) {
        evolutionVC = PokeEvolutionViewController()
        evolutionVC?.pokemonChain = pokemonChain
        addChild(evolutionVC!)
    }

}

extension PokeDetailViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        switch index {
        case 0:
            showEvolution(false)
        case 1:
            if isFirstTimeOpenEvolution {
                isFirstTimeOpenEvolution = false
                setupEvolution()
            }
            showEvolution(true)
        default:
            break
        }
    }
}

extension PokeDetailViewController {
    public func setupLayout() {
        setupHeader()
        setupCustomSegmentedControl()
        setupStat()
    }

    public func setupHeader() {
        pokemonImg.heightAnchor.constraint(equalToConstant: 150).isActive = true
        pokemonImg.widthAnchor.constraint(equalToConstant: 150).isActive = true

        let stackView = UIStackView(arrangedSubviews: [pokemonImg, pokemonName])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }

    private func setupCustomSegmentedControl() {
        view.addSubview(customSegmentedControl)
        customSegmentedControl.delegate = self
        customSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        customSegmentedControl.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 20).isActive = true
        customSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupStat() {
        guard let statView = statVC?.view else { return }

        view.addSubview(statView)
        statView.translatesAutoresizingMaskIntoConstraints = false
        statView.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 2).isActive = true
        statView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupEvolution() {
        guard let evolutionView = evolutionVC?.view else { return }

        view.addSubview(evolutionView)
        evolutionView.translatesAutoresizingMaskIntoConstraints = false
        evolutionView.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 2).isActive = true
        evolutionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        evolutionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        evolutionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, action: String, handler: ((UIAlertAction) -> Void)? = nil) {
        guard presentedViewController == nil else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: handler))

        present(alert, animated: true)
    }
}
