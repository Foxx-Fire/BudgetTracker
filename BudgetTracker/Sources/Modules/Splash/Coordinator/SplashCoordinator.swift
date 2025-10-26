//
//  SplashCoordinator.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

class SplashCoordinator: Coordinator {
    private let window: UIWindow
    var onFinish: (() -> Void)?  // ← "Сообщи APP COORDINATOR'у когда я закончу"
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let splashVC = SplashViewControllerFactory.create()
        splashVC.onFinish = { [weak self] in  // ← Подписываемся на событие от VC
            self?.onFinish?()  // → Когда VC сообщил - сообщаем AppCoordinator
        }
        window.rootViewController = splashVC
        window.makeKeyAndVisible()
    }
}
