//
//  OnboardingDataService.swift
//  BudgetTracker
//
//  Created by FoxxFire on 18.10.2025.
//

import Foundation

protocol OnboardingDataServiceProtocol {
    func getAllBackgroundPages() -> [OnboardingBackgroundModel]
    func getAllContentPages() -> [OnboardingContentModel]
}

final class OnboardingDataService: OnboardingDataServiceProtocol {
    
    func getAllBackgroundPages() -> [OnboardingBackgroundModel] {
        return OnboardingBackgroundModel.pages
    }
    
    func getAllContentPages() -> [OnboardingContentModel] {
        return OnboardingContentModel.pages
    }
}
