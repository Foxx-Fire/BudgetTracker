//
//  SplashView.swift
//  BudgetTracker
//
//  Created by FoxxFire on 16.10.2025.
//

import UIKit

enum SplashConstants {
    
    enum Fonts {
        static let mediumTitle = UIFont(name: "Inter_18pt-Light", size: 16)
    }
    
    enum Layout {
        static let imageTopPercent: CGFloat = 337 / 812 // ≈ 0.415
        static let imageWidthPercent: CGFloat = 164 / 375 // ≈ 0.437
        static let imageHeightPercent: CGFloat = 155 / 812 // ≈ 0.191
        static let textTopSpacingPercent: CGFloat = 215 / 812 // ≈ 0.265
        static let textWidthPercent: CGFloat = 115 / 375 // ≈ 0.307
        static let textHeightPercent: CGFloat = 20 / 812 // ≈ 0.025
    }
}

class SplashView: UIView {
    
    private let splashImageView = UIImageView()
    private let titleLabel = UILabel()
    
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
        backgroundColor = .appPink
        
        splashImageView.contentMode = .scaleAspectFit
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .appWhite
        titleLabel.font = SplashConstants.Fonts.mediumTitle
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(splashImageView)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            splashImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            splashImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: UIScreen.main.bounds.height * SplashConstants.Layout.imageTopPercent
            ),
            splashImageView.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: SplashConstants.Layout.imageWidthPercent
            ),
            splashImageView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: SplashConstants.Layout.imageHeightPercent
            ),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(
                equalTo: splashImageView.bottomAnchor,
                constant: UIScreen.main.bounds.height * SplashConstants.Layout.textTopSpacingPercent
            ),
            titleLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: SplashConstants.Layout.textWidthPercent
            ),
            titleLabel.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: SplashConstants.Layout.textHeightPercent
            )
        ])
    }
    
    func configure(with imageName: String, title: String) {
        splashImageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
