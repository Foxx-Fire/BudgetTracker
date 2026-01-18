//
//  HomeView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//
import UIKit

enum ConstantsDailyView {
    static let horizontalMargin: CGFloat = 16
    static let totalContentPadding: CGFloat = 16
    static let minSpacingBetweenLabels: CGFloat = 8
    
    // Простые отступы вместо сложных расчетов
    static let tableTopOffset: CGFloat = 16
    static let totalToTabBarOffset: CGFloat = 16
    static let totalContainerHeight: CGFloat = 44
    static let cellHeight: CGFloat = 79 // фиксированная высота ячейки
}

final class DailyView: UIView {
    
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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 76, bottom: 0, right: 16)
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка Total Container для футера
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
        
        totalContainer.addSubview(totalLabel)
        totalContainer.addSubview(totalAmount)
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        // Констрейнты для лейблов ВНУТРИ контейнера
        NSLayoutConstraint.activate([
            totalLabel.leadingAnchor.constraint(equalTo: totalContainer.leadingAnchor, constant: 16),
            totalLabel.centerYAnchor.constraint(equalTo: totalContainer.centerYAnchor),
            
            totalAmount.trailingAnchor.constraint(equalTo: totalContainer.trailingAnchor, constant: -16),
            totalAmount.centerYAnchor.constraint(equalTo: totalContainer.centerYAnchor),
            totalAmount.leadingAnchor.constraint(greaterThanOrEqualTo: totalLabel.trailingAnchor, constant: 8)
        ])
        
        // Констрейнты для таблицы (занимает весь DailyView)
        NSLayoutConstraint.activate([
            // MARK: - Table View Constraints (занимает весь доступный размер)
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Обновляем размер footerView при изменении layout
        // Это нужно делать здесь, так как bounds.width известен только после layout
        totalContainer.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width, // ширина DailyView
            height: 44           // фиксированная высота
        )
        
        // Устанавливаем как футер (единожды)
        if tableView.tableFooterView == nil {
            tableView.tableFooterView = totalContainer
        }
    }
    
    func configure(total: String) {
        totalAmount.text = total
        
        totalContainer.setNeedsLayout()
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

