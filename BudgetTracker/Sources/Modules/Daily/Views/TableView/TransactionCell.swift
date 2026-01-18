//
//  TransactionViewCell.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//
import UIKit

enum ConstantsTransactionCell {
    // Размеры контейнеров
    static let categoryContainerSize: CGFloat = 48
    static let bankContainerSize: CGFloat = 18
    static let categoryImageSize: CGFloat = 23
    static let bankImageSize: CGFloat = 16
    
    // Отступы
    static let horizontalMargin: CGFloat = 16
    static let stackToTextSpacing: CGFloat = 12
    static let nameToTimeSpacing: CGFloat = 4
    static let verticalPadding: CGFloat = 16
    static let minTextSpacing: CGFloat = 8
    
    // Stack view
    static let stackSpacing: CGFloat = -8 // Отрицательный для наложения
}

final class TransactionCell: UITableViewCell {
    
    private let categoryContainer = UIView()
    private let categoryBackground = UIView()
    private let categoryImageView = UIImageView()
    
    private let bankContainer = UIView()
    private let bankBackground  = UIView()
    private let bankImageView = UIImageView()
    
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let currencyLabel = UILabel()
    private let amountLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        contentView.backgroundColor = .appBackground
        
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.spacing = -8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryContainer.translatesAutoresizingMaskIntoConstraints = false
        categoryBackground.backgroundColor = .appBackgroundHomeImage
        categoryBackground.layer.cornerRadius = 24
        categoryBackground.clipsToBounds = true
        categoryBackground.translatesAutoresizingMaskIntoConstraints = false
        
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.clipsToBounds = true
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        bankContainer.translatesAutoresizingMaskIntoConstraints = false
        bankBackground .backgroundColor = .appBackgroundHomeImage
        bankBackground .layer.cornerRadius = 8
        bankBackground .clipsToBounds = true
        bankBackground .translatesAutoresizingMaskIntoConstraints = false
        
        bankImageView.contentMode = .scaleAspectFit
        bankImageView.layer.cornerRadius = 6
        bankImageView.clipsToBounds = true
        bankImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textColor = .appBlack
        nameLabel.font = UIFont.interMedium(size: 15)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.textColor = .appBlack
        timeLabel.font = UIFont.interRegular(size: 11)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currencyLabel.textColor = .appGreen
        currencyLabel.font = UIFont.interMedium(size: 15)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel.textColor = .appGreen
        amountLabel.font = UIFont.interMedium(size: 15)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryContainer.addSubview(categoryBackground)
        categoryContainer.addSubview(categoryImageView)
        
        bankContainer.addSubview(bankBackground)
        bankContainer.addSubview(bankImageView)
        
        stackView.addArrangedSubview(categoryContainer)
        stackView.addArrangedSubview(bankContainer)
        
        contentView.addSubview(stackView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Stack View Constraints
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: ConstantsTransactionCell.horizontalMargin
            ),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // MARK: - Category Constraints
            categoryContainer.widthAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.categoryContainerSize
            ),
            categoryContainer.heightAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.categoryContainerSize
            ),
            categoryBackground.topAnchor.constraint(
                equalTo: categoryContainer.topAnchor
            ),
            categoryBackground.leadingAnchor.constraint(
                equalTo: categoryContainer.leadingAnchor
            ),
            categoryBackground.trailingAnchor.constraint(
                equalTo: categoryContainer.trailingAnchor
            ),
            categoryBackground.bottomAnchor.constraint(
                equalTo: categoryContainer.bottomAnchor
            ),
            categoryImageView.centerXAnchor.constraint(
                equalTo: categoryContainer.centerXAnchor
            ),
            categoryImageView.centerYAnchor.constraint(
                equalTo: categoryContainer.centerYAnchor
            ),
            categoryImageView.widthAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.categoryImageSize
            ),
            categoryImageView.heightAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.categoryImageSize
            ),
            
            // MARK: - Bank Constraints
            bankContainer.widthAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.bankContainerSize
            ),
            bankContainer.heightAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.bankContainerSize
            ),
            bankBackground.topAnchor.constraint(equalTo: bankContainer.topAnchor),
            bankBackground.leadingAnchor.constraint(equalTo: bankContainer.leadingAnchor),
            bankBackground.trailingAnchor.constraint(equalTo: bankContainer.trailingAnchor),
            bankBackground.bottomAnchor.constraint(equalTo: bankContainer.bottomAnchor),
            bankImageView.centerXAnchor.constraint(equalTo: bankContainer.centerXAnchor),
            bankImageView.centerYAnchor.constraint(equalTo: bankContainer.centerYAnchor),
            bankImageView.widthAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.bankImageSize
            ),
            bankImageView.heightAnchor.constraint(
                equalToConstant: ConstantsTransactionCell.bankImageSize
            ),
            
            // MARK: - Text Labels Constraints
            nameLabel.leadingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: ConstantsTransactionCell.stackToTextSpacing
            ),
            nameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: ConstantsTransactionCell.verticalPadding
            ),
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: amountLabel.leadingAnchor,
                constant: -ConstantsTransactionCell.minTextSpacing
            ),
            
            timeLabel.leadingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: ConstantsTransactionCell.stackToTextSpacing
            ),
            timeLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: ConstantsTransactionCell.nameToTimeSpacing
            ),
            timeLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: amountLabel.leadingAnchor,
                constant: -ConstantsTransactionCell.minTextSpacing
            ),
            timeLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -ConstantsTransactionCell.verticalPadding
            ),
            
            amountLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -ConstantsTransactionCell.horizontalMargin
            ),
            amountLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            amountLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: nameLabel.trailingAnchor,
                constant: ConstantsTransactionCell.minTextSpacing
            )
        ])
    }
    
    func configure(
        with transaction: Transaction,
        categoryIconName: String,
        bankIconName: String,
        formattedAmount: String
    ) {
        nameLabel.text = transaction.personName
        timeLabel.text = transaction.timeString
        amountLabel.text = formattedAmount
        categoryImageView.image = UIImage(named: categoryIconName)
        bankImageView.image = UIImage(named: bankIconName)
    }
}
