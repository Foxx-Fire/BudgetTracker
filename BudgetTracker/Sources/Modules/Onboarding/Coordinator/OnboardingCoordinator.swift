//
//  OnboardingCoordinator.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//
import UIKit

class OnboardingCoordinator: Coordinator {
    
    private let window: UIWindow
    var onFinish: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
    
        let onboardingVC = OnboardingContainerViewController()
        onboardingVC.onFinish = { [weak self] in
            self?.onFinish?()
        }
        
        window.rootViewController = onboardingVC
    }
}

