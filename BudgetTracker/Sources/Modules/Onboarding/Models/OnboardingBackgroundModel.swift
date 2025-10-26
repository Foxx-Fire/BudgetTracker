//
//  OnboardingViewModel.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

struct OnboardingBackgroundModel {
    let backgroundImageName: String
    let showContentCard: Bool
}

extension OnboardingBackgroundModel {
    static let pages: [OnboardingBackgroundModel] = [
        OnboardingBackgroundModel(backgroundImageName: "Onboarding1", showContentCard: true),
        OnboardingBackgroundModel(backgroundImageName: "Onboarding2", showContentCard: true),
        OnboardingBackgroundModel(backgroundImageName: "Onboarding3", showContentCard: true)
    ]
}
