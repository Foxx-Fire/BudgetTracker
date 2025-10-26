//
//  OnboardingContentModel.swift
//  BudgetTracker
//
//  Created by FoxxFire on 19.10.2025.
//

import Foundation

struct OnboardingContentModel {
    let title: String
    let description: String
}

extension OnboardingContentModel {
    static let pages: [OnboardingContentModel] = [
        OnboardingContentModel(
            title: "Synth polaroid",
            description: "In the tumultuous business of cutting-in and attending to a whale, there."
        ),
        OnboardingContentModel(
            title: "Retro occupy",
            description: "Being the savage's bowsman, that is, the person who pulled the bow-оar in."
        ),
        OnboardingContentModel(
            title: "Synth polaroid",
            description: "In the tumultuous business of cutting-in and attending to a whale, there."
        )
    ]
}
