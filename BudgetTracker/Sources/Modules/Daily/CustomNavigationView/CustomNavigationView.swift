//
//  CustomNavigationView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 28.10.2025.
//
import UIKit

enum ConstantsNavigation {
    static let height: CGFloat = 120 // Фиксированная высота, потом добавим календарь
    static let horizontalPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 20
}

final class CustomNavigationView: UIView {
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let searchButton = UIButton()
    private let container = UIView()
    
    // MARK: - Properties
    private var isSearchMode = false
    var onSearchTapped: (() -> Void)? = nil
    
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
        backgroundColor = .clear
        
        container.backgroundColor = .appWhite
        container.layer.cornerRadius = 26
        container.layer.shadowRadius = 8
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 0.1
        container.layer.masksToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Daily transaction"
        titleLabel.font = UIFont.interBold(size: 17)
        titleLabel.textColor = .appBlack
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .appBlack
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addAction(UIAction { [weak self] _ in
            self?.toggleSearchMode()
        }, for: .touchUpInside)
        
        
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: container.leadingAnchor,
                constant: ConstantsNavigation.horizontalPadding
            ),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(
                equalTo: container.trailingAnchor,
                constant: -ConstantsNavigation.horizontalPadding
            ),
            searchButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 36),
            searchButton.heightAnchor.constraint(equalToConstant: 36),
            
            // Заголовок не должен заезжать на кнопку
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: searchButton.leadingAnchor,
                constant: -8
            )
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    //MARK: - Actions
    private func toggleSearchMode() {
        isSearchMode.toggle()
        
        if isSearchMode {
            searchButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        } else {
            self.searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        }
        
        onSearchTapped?()
    }
    
//    func setSearchMode(_ isActive: Bool) {
//        isSearchMode = isActive
//        toggleSearchMode()
//    }
}
