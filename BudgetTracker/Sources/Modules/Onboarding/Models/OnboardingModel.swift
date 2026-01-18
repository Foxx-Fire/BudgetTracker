//
//  OnboardingViewModel.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

struct OnboardingBackgroundModel: Codable {
    let backgroundImageName: String
    let showContentCard: Bool
}

struct OnboardingContentModel: Codable {
    let title: String
    let description: String
}


extension OnboardingBackgroundModel {
    static let pages: [OnboardingBackgroundModel] = [
        OnboardingBackgroundModel(backgroundImageName: "staying", showContentCard: true),
        OnboardingBackgroundModel(backgroundImageName: "writing", showContentCard: true),
        OnboardingBackgroundModel(backgroundImageName: "sitting", showContentCard: true)
    ]
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
