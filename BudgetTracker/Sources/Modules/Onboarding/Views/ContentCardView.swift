//
//  ContentCardView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 20.10.2025.
//

import UIKit

enum ContentCardConstants {    
    enum Fonts {
        static let title = UIFont(name: "Inter_24pt-Bold.ttf", size: 24)
        static let description = UIFont.systemFont(ofSize: 16)
        static let button = UIFont.boldSystemFont(ofSize: 16)
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 12
        
        static let shadowOpacity: Float = 0.1
        static let shadowOffset = CGSize(width: 0, height: 4)
        static let shadowRadius: CGFloat = 20
        
        static let stackSpacing: CGFloat = 18
        static let stackTopOffset: CGFloat = 545 - 511
        static let titleWidthOffset: CGFloat = 171
        static let descriptionWidthOffset: CGFloat = 287
        
        //  static let buttonTopOffset: CGFloat = 51
        static let buttonWidthOffset: CGFloat = 255
        static let buttonHeightOffset: CGFloat = 48
        static let buttonBottomOffset: CGFloat = -(270 - 190.5 - 34)
        
        static let cardHorizontalInsetPercent: CGFloat = 15 / 375 //≈ 0.04
        static let cardTopPercent: CGFloat = 511 / 812 //≈ 0.629
        
        // Относительно карточки
        static let titleTopPercent: CGFloat = (545 - 511) / 301 //≈ 0.113  // 301 - высота карточки (812-511)
        static let titleWidthPercent: CGFloat = 171 / 327 //≈ 0.523  // 327 - ширина карточки (375-15*2)
        static let descriptionTopSpacingPercent: CGFloat = 19 / 301 //≈ 0.063
        static let descriptionWidthPercent: CGFloat = 287 / 327 //≈ 0.878
        static let buttonTopSpacingPercent: CGFloat = 51 / 301 //≈ 0.169
        static let buttonWidthPercent: CGFloat = 255 / 327 //≈ 0.780
    }
}

class ContentCardView: UIView {
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton()
    private let stackView = UIStackView()
    
    // MARK: - Properties
    var onAction: (() -> Void)?
    
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
        layer.cornerRadius = ContentCardConstants.Layout.cornerRadius
        layer.shadowColor = UIColor.appShadow
        layer.shadowOpacity = ContentCardConstants.Layout.shadowOpacity
        layer.shadowOffset = ContentCardConstants.Layout.shadowOffset
        layer.shadowRadius = ContentCardConstants.Layout.shadowRadius
        
        stackView.axis = .vertical
        stackView.spacing = ContentCardConstants.Layout.stackSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = ContentCardConstants.Fonts.title
        titleLabel.textColor = .appBlack
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = ContentCardConstants.Fonts.description
        descriptionLabel.textColor = .appBlack
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        actionButton.setTitle("I'm interested", for: .normal)
        actionButton.backgroundColor = .appPink
        actionButton.setTitleColor(.appWhite, for: .normal)
        actionButton.layer.cornerRadius = ContentCardConstants.Layout.buttonCornerRadius
        actionButton.titleLabel?.font = ContentCardConstants.Fonts.button
        
        let buttonAction = UIAction { [weak self] _ in
            // Анимация для actionButton
            UIView.animate(withDuration: 0.05, animations: {
                self?.actionButton.alpha = 0.7
                self?.actionButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.05) {
                    self?.actionButton.alpha = 1.0
                    self?.actionButton.transform = .identity
                }
                self?.onAction?()
            }
        }
        actionButton.addAction(buttonAction, for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: ContentCardConstants.Layout.stackTopOffset),
            
            titleLabel.widthAnchor.constraint(equalToConstant: ContentCardConstants.Layout.titleWidthOffset),
            descriptionLabel.widthAnchor.constraint(equalToConstant: ContentCardConstants.Layout.descriptionWidthOffset),
            
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: ContentCardConstants.Layout.buttonWidthOffset),
            actionButton.heightAnchor.constraint(equalToConstant: ContentCardConstants.Layout.buttonHeightOffset),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ContentCardConstants.Layout.buttonBottomOffset)
        ])
    }
    
    func configure(title: String, description: String, buttonTitle: String? = nil) {
        titleLabel.text = title
        descriptionLabel.text = description
        
        // Если передали кастомный текст кнопки - используем его
        if let buttonTitle = buttonTitle {
            actionButton.setTitle(buttonTitle, for: .normal)
        } else {
            // Иначе используем текст по умолчанию
            actionButton.setTitle("I'm interested", for: .normal)
        }
    }
}
