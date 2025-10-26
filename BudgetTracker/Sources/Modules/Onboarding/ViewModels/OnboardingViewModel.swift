//
//  Onbo.swift
//  BudgetTracker
//
//  Created by FoxxFire on 18.10.2025.
//
import Foundation

protocol OnboardingViewModelProtocol {
    var pageCount: Int { get }
    func getBackgroundModel(for page: Int) -> OnboardingBackgroundModel
    func getContentModel(for page: Int) -> OnboardingContentModel?
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    private let dataService: OnboardingDataServiceProtocol
    private var backgroundPages: [OnboardingBackgroundModel] = []
    private var contentPages: [OnboardingContentModel] = []
    
    init(dataService: OnboardingDataServiceProtocol = OnboardingDataService() ) {
        self.dataService = dataService
        self.backgroundPages = dataService.getAllBackgroundPages()
        self.contentPages = dataService.getAllContentPages()
    }
    
    var pageCount: Int {
        backgroundPages.count
    }
    
    func getBackgroundModel(for page: Int) -> OnboardingBackgroundModel {
        guard page < backgroundPages.count else {
            return OnboardingBackgroundModel(
                backgroundImageName: "",
                showContentCard: false)
        }
        
        return backgroundPages[page]
    }
    
    func getContentModel(for page: Int) -> OnboardingContentModel? {
        guard page < contentPages.count else {
            return nil
        }
        return contentPages[page]
    }
}
