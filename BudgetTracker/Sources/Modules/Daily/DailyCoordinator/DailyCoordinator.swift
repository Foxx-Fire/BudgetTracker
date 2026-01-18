//
//  HomeCoordinator.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

final class DailyCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = DailyViewController()
        navigationController.pushViewController(homeVC, animated: false)
    }
}
