//
//  OnboardingPageView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 20.10.2025.
//

import UIKit

enum OnboardingPageConstants {
    enum Layout {
        static let cardHorizontalInsetPercent: CGFloat = 15 / 375// ≈ 0.04
        static let cardTopPercent: CGFloat = 511 / 812 //≈ 0.629
        static let cardHeightPercent: CGFloat = 270 / 812 //≈ 0.371 // 812 - 511 = 301
    }
}

final class OnboardingPageView: UIView {
    
    // MARK: - UI Elements
    private let backgroundView = OnboardingBackgroundView()
    private let contentCardView = ContentCardView()
    private let skipButton = UIButton()
    
    // MARK: - Properties
    var onAction: (() -> Void)?
    var onSkip: (() -> Void)?
    
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
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.systemPink, for: .normal)
        skipButton.titleLabel?.font = .systemFont(ofSize: 16)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        let skipTapped = UIAction{ [weak self] _ in
            // Анимация для SKIP button
            UIView.animate(withDuration: 0.05, animations: {
                self?.skipButton.alpha = 0.7
                self?.skipButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.05) {
                    self?.skipButton.alpha = 1.0
                    self?.skipButton.transform = .identity
                }
                
                self?.onSkip?()
            }
        }
        
        skipButton.addAction(skipTapped, for: .touchUpInside)
        
        contentCardView.translatesAutoresizingMaskIntoConstraints = false
        contentCardView.onAction = { [weak self] in
            self?.onAction?()
        }
        
        addSubview(backgroundView)
        addSubview(skipButton)
        addSubview(contentCardView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            skipButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            contentCardView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: UIScreen.main.bounds.width *
                OnboardingPageConstants.Layout.cardHorizontalInsetPercent
            ),
            contentCardView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -UIScreen.main.bounds.width *
                OnboardingPageConstants.Layout.cardHorizontalInsetPercent
            ),
            contentCardView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: UIScreen.main.bounds.height *
                OnboardingPageConstants.Layout.cardTopPercent
            ),
            contentCardView.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.height *
                OnboardingPageConstants.Layout.cardHeightPercent)
        ])
    }
    
    func configure(
        backgroundImageName: String,
        currentPage: Int,
        totalPages: Int,
        cardTitle: String?,
        cardDescription: String?
    ) {
        backgroundView.configure(
            with: backgroundImageName,
            currentPage: currentPage,
            totalPages: totalPages
        )
        
        if let cardTitle = cardTitle, let cardDescription = cardDescription {
            if currentPage == totalPages - 1 {
                // Последняя страница - меняем текст кнопки
                contentCardView.configure(
                    title: cardTitle,
                    description: cardDescription,
                    buttonTitle: "Get Started" // ← специальный текст для завершения
                )
            } else {
                // Обычные страницы
                contentCardView.configure(
                    title: cardTitle,
                    description: cardDescription
                    // buttonTitle по умолчанию "I'm interested"
                )
            }
            contentCardView.isHidden = false
        } else {
            contentCardView.isHidden = true
        }
        
        // На последней странице можно скрыть Skip
        skipButton.isHidden = (currentPage == totalPages - 1)
    }
}
