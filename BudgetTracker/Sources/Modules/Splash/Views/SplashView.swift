//
//  SplashView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//

import UIKit

enum SplashConstants {
    enum Layout {
        static let activityIndicatorSize: CGFloat = 50
        static let logoTopPercent: CGFloat = 128 / 812 //≈ 0.158 (как в онбординге)
        static let logoWidthPercent: CGFloat = 232 / 375 //≈ 0.619 (как в онбординге)
        static let logoHeightPercent: CGFloat = 251 / 812 //≈ 0.309 (как в онбординге)
    }
}

final class SplashView: UIView {
    
    // MARK: - UI Elements
    private let backgroundImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
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
        
        // Используем первый фон из онбординга для единообразия
        backgroundImageView.image = UIImage(named: "staying")
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.color = .appPink
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        addSubview(backgroundImageView)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background Image (как в онбординге)
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: UIScreen.main.bounds.height *
                SplashConstants.Layout.logoTopPercent
            ),
            backgroundImageView.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: SplashConstants.Layout.logoWidthPercent
            ),
            backgroundImageView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: SplashConstants.Layout.logoHeightPercent
            ),
            
            // Activity Indicator (внизу экрана)
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -100
            )
        ])
    }
    
    // MARK: - Public Methods
    func startLoadingAnimation() {
        activityIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
    }
}
