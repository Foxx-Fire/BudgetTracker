//
//  HomeViewController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

final class HomeViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    private let viewModel: HomeViewModelProtocol
    private let homeView: HomeView
    
    // MARK: - Init
    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {
        self.viewModel = viewModel
        self.homeView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        homeView.setupTableViewDataSource(self)
        homeView.setupTableViewDelegate(self)
        homeView.configure(total: viewModel.formattedTotal)
        homeView.reloadTableView()
    }
    
    private func setupNavigationBar() {
        title = "Daily Transaction"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        
        let transaction = viewModel.getTransaction(for: indexPath.row)
        let categoryIcon = viewModel.getCategoryIconName(for: transaction)
        let bankIcon = viewModel.getBankIconName(for: transaction)
        let formattedAmount = viewModel.getFormattedAmount(for: transaction)
        
        cell.configure(
            with: transaction,
            categoryIconName: categoryIcon,
            bankIconName: bankIcon,
            formattedAmount: formattedAmount 
        )
        return cell
    }
}
