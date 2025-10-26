//
//  HomeView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//
import UIKit

enum ConstantsHomeView {
    // Высота экрана из макета
    private static let baseScreenHeight: CGFloat = 811 // 185.85 + 625.15
    
    // Значения из макета
    private static let baseTableTopOffset: CGFloat = 16.15     // от навигатора до таблицы
    private static let baseTableHeight: CGFloat = 389          // ВЫСОТА ТАБЛИЦЫ: 811 - 185.85 - 16.15 - 220
    private static let baseTotalToTabBarOffset: CGFloat = 56.46 // от Total до таббара
    private static let baseTotalContainerHeight: CGFloat = 19   // высота Total из макета
    
    // Процентные соотношения
    static var tableTopOffset: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return (baseTableTopOffset / baseScreenHeight) * screenHeight
    }
    
    static var tableHeight: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return (baseTableHeight / baseScreenHeight) * screenHeight
    }
    
    static var totalToTabBarOffset: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return (baseTotalToTabBarOffset / baseScreenHeight) * screenHeight
    }
    
    static var totalContainerHeight: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return (baseTotalContainerHeight / baseScreenHeight) * screenHeight
    }
    
    // Фиксированные отступы
    static let horizontalMargin: CGFloat = 16
    static let totalContentPadding: CGFloat = 16
    static let minSpacingBetweenLabels: CGFloat = 8
}

final class HomeView: UIView {
    
    // MARK: - UI Elements
    private let tableView = UITableView()
    private let totalLabel = UILabel()
    private let totalAmount = UILabel()
    private let totalContainer = UIView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .appBackground
        
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        
        tableView.backgroundColor = .appBackground
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .appLightGray
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        totalContainer.backgroundColor = .appWhite
        totalContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        totalLabel.font = UIFont.interMedium(size: 15)
        totalLabel.textAlignment = .left
        totalLabel.textColor = .appDarkGray
        totalLabel.text = "Total:"
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalAmount.font = UIFont.interBold(size: 18)
        totalAmount.textColor = .appBlack
        totalAmount.textAlignment = .right
        totalAmount.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
        addSubview(totalContainer)
        totalContainer.addSubview(totalLabel)
        totalContainer.addSubview(totalAmount)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: ConstantsHomeView.tableTopOffset
            ),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(
                equalToConstant: ConstantsHomeView.tableHeight
            ), // ⬅️ ФИКСИРОВАННАЯ ВЫСОТА!
            
            // MARK: - Total Container Constraints
            totalContainer.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantsHomeView.horizontalMargin
            ),
            totalContainer.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantsHomeView.horizontalMargin
            ),
            totalContainer.topAnchor.constraint(
                equalTo: tableView.bottomAnchor, constant: 8),
            totalContainer.heightAnchor.constraint(
                equalToConstant: ConstantsHomeView.totalContainerHeight
            ),
            
            // MARK: - Total Label Constraints
            totalLabel.leadingAnchor.constraint(
                equalTo: totalContainer.leadingAnchor,
                constant: ConstantsHomeView.totalContentPadding
            ),
            totalLabel.centerYAnchor.constraint(
                equalTo: totalContainer.centerYAnchor
            ),
            
            // MARK: - Total Amount Constraints
            totalAmount.trailingAnchor.constraint(
                equalTo: totalContainer.trailingAnchor,
                constant: -ConstantsHomeView.totalContentPadding
            ),
            totalAmount.centerYAnchor.constraint(
                equalTo: totalContainer.centerYAnchor
            ),
            totalAmount.leadingAnchor.constraint(
                greaterThanOrEqualTo: totalLabel.trailingAnchor,
                constant: ConstantsHomeView.minSpacingBetweenLabels
            )
        ])
    }
    
    func configure(total: String) {
        totalAmount.text = total
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func setupTableViewDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func setupTableViewDelegate(_ delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }
}

