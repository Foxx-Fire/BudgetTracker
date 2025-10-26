//
//  SplashViewControllerFactory.swift
//  BudgetTracker
//
//  Created by FoxxFire on 18.10.2025.
//

import Foundation

enum SplashViewControllerFactory {
    static func create() -> SplashViewController {
        let viewModel = SplashViewModel()
        return SplashViewController(viewModel: viewModel)
    }
}
