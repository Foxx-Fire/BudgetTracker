//
//  SplashViewModel.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

protocol SplashViewModelProtocol {
    var splashModel: SplashModel { get }
}

final class SplashViewModel: SplashViewModelProtocol {
    let splashModel: SplashModel = SplashModel.default
}
