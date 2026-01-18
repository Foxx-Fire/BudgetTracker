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
    private var onboardingCoordinator: OnboardingCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let onboardingWasShown = UserDefaults.standard.bool(forKey: "onboardingWasShown")
        
        if onboardingWasShown == true {
          //  showMainApp()
            showLogin()
        } else {
            showSplash()
        }
    }
    
    private func showSplash() {
        // Показываем Splash Screen перед онбордингом для плавной загрузки
        let splashVC = SplashViewController()
        splashVC.onFinish = { [weak self] in
            self?.showOnboarding()
        }
        window.rootViewController = splashVC
    }
    
    private func showOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(window: window)
        self.onboardingCoordinator = onboardingCoordinator
        onboardingCoordinator.onFinish = { [weak self] in
            // Сохраняем флаг что онбординг пройден
            UserDefaults.standard.set(true, forKey: "onboardingWasShown")
            self?.onboardingCoordinator = nil
           // self?.showMainApp() // ← после онбординга запускаем таббар
            self?.showLogin()
        }
        onboardingCoordinator.start()
    }
    
//    private func showMainApp() {
//        let tabBarController = CustomTabBarController()
//        window.rootViewController = tabBarController
//    }
    
    private func showLogin() {
        window.rootViewController =
        DailyViewController()
        //LoginViewController()
    }
}
