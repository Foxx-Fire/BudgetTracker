//
//  OnboardingPageView.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

enum OnboardingBackgroundConstants {
    enum Colors {
        static let pageControlCurrent = UIColor.systemPink
    }
    
    enum Layout {
        static let imageTopPercent: CGFloat = 128 / 812 //≈ 0.158
        static let imageWidthPercent: CGFloat = 232 / 375 //≈ 0.619
        static let imageHeightPercent: CGFloat = 251 / 812 //≈ 0.309
    }
}

final class OnboardingBackgroundView: UIView {
    
    // MARK: - UI Elements
    private let backgroundImageView = UIImageView()
    
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
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: UIScreen.main.bounds.height *
                OnboardingBackgroundConstants.Layout.imageTopPercent
            ),
            backgroundImageView.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: OnboardingBackgroundConstants.Layout.imageWidthPercent
            ),
            backgroundImageView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: OnboardingBackgroundConstants.Layout.imageHeightPercent
            )
        ])
    }
    
    func configure(with imageName: String) {
        backgroundImageView.image = UIImage(named: imageName)
    }
}
