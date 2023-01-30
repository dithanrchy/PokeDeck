//
//  PokeListViewController.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import RxCocoa
import RxSwift
import UIKit

class PokeListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    var pokemons = [Pokemon]() {
        didSet {
            tableView.reloadData()
        }
    }

    private var nextUrl: String?

    private let pokemonViewModel = PokeListViewModel()
    private let disposeBag = DisposeBag()

    private let refreshControl = UIRefreshControl()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Pokemon"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokeListCell", bundle: nil), forCellReuseIdentifier: "pokeListCell")

        if !Reachability.isConnectedToNetwork() {
            showAlert(title: "No internet connection.", message: "Please check your connection and try again.", action: "OK")
        }

        pokemonViewModel.isLoading.observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                if result {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
            })
            .disposed(by: disposeBag)

        pokemonViewModel.getPokemonListObservable().observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.pokemons = result
                self.refreshControl.endRefreshing()
            }, onError: { _ in
                self.showAlert(title: "Failed to get Pokemon List", message: "Try Again", action: "OK")
                self.refreshControl.endRefreshing()
            },
            onCompleted: {
            })
            .disposed(by: disposeBag)

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc private func refreshData() {
        pokemonViewModel.refresh()
    }
}

extension PokeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayVC = PokeDetailViewController()
        displayVC.pokemonDetail = pokemons[indexPath.row]
        navigationController?.pushViewController(displayVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension PokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pokemons.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "pokeapi_bw")!,
                title: "Empty Pokemon List",
                message: "Please connect to the internet to get pokemon data",
                centerYAnchorConstant: -50)
        } else {
            self.tableView.restore()
        }
        return pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeListCell", for: indexPath) as? PokeListCell

        cell?.configure(name: pokemons[indexPath.row].name, urlImage: pokemons[indexPath.row].sprites.frontDefault)

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            pokemonViewModel.loadNext()
        }
    }
}
