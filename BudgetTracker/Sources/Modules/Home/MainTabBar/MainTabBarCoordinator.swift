//
//  MainTabBarCoordinator.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = CustomTabBarController()
        tabBarController.delegate = self
        
        // Создаем NavigationController для Home таба
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        homeCoordinator.start()
        homeNavigationController.tabBarItem = UITabBarItem(title: "Daily", image: nil, tag: 0)
        
        // Создаем остальные табы (заглушки)
        let statVC = UIViewController()
        statVC.tabBarItem = UITabBarItem(title: "Stat", image: nil, tag: 1)
        
        let budgetVC = UIViewController()
        budgetVC.tabBarItem = UITabBarItem(title: "Budget", image: nil, tag: 2)
        
        let profileVC = UIViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 3)
        
        // Устанавливаем контроллеры в TabBar
        tabBarController.setViewControllers([
            homeNavigationController,
            statVC,
            budgetVC,
            profileVC
        ], animated: false)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

extension MainTabBarCoordinator: CustomTabBarControllerDelegate {
    func didSelectTab(at index: Int) {
        print("Selected tab at index: \(index)")
    }
    
    func didTapCenterButton() {
        print("Center button tapped - show transaction creation")
        // Здесь можно показать экран создания транзакции
    }
}
