//
//  AppCoordinator.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

class AppCoordinator {

    // ссылка на главное окно приложения, чтобы координатор мог менять rootViewController
    private let window: UIWindow // ← Храним окно, чтобы управлять им
    private var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showSplash()
       // showMainApp()
    }
    
    private func showSplash() {
        let splashCoordinator = SplashCoordinator(window: window)
        splashCoordinator.onFinish = { [weak self] in
            self?.showOnboarding()
        }
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
    }
    
    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(window: window)
        onboardingCoordinator.onFinish = { [weak self] in
            self?.showMainApp()
        }
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showMainApp() {
        let mainCoordinator = MainTabBarCoordinator(window: window)
        mainCoordinator.start()
    }
}
