//
//  SplashModel.swift
//  BudgetTracker
//
//  Created by FoxxFire on 20.10.2025.
//

import Foundation

struct SplashModel {
    let splashImageName: String
    let splashLabel: String
}

extension SplashModel {
    static let `default` = SplashModel(
        splashImageName: "Splash",
        splashLabel: "BudgetTracker"
    )
}
