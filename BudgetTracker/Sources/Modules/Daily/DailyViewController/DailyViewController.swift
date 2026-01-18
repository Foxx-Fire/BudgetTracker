//
//  HomeViewController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

final class DailyViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: DailyViewModelProtocol
    private let homeView: DailyView
    private let customNavView = CustomNavigationView()
    
    // MARK: - Init
    init(viewModel: DailyViewModelProtocol = DailyViewModel()) {
        self.viewModel = viewModel
        self.homeView = DailyView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        homeView.setupTableViewDataSource(self)
        homeView.setupTableViewDelegate(self)
        homeView.configure(total: viewModel.formattedTotal)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(customNavView)
        customNavView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavView.heightAnchor.constraint(equalToConstant: ConstantsNavigation.height),
            
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.topAnchor.constraint(equalTo: customNavView.bottomAnchor, constant: 11),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Пример: переход на экран деталей транзакции
//    private func showTransactionDetails(_ transaction: Transaction) {
//        let detailsVC = TransactionDetailsViewController(transaction: transaction)
//        
//        // Используем стандартную навигацию!
//        navigationController?.pushViewController(detailsVC, animated: true)
//        
//        // Автоматически получаем:
//        // - Анимацию push
//        // - Back button
//        // - Swipe-back жест
//        // - Title в navigation bar (если нужно)
//    }
}

extension DailyViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantsDailyView.cellHeight
    }
    
    //MARK: - добавить удаление
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
