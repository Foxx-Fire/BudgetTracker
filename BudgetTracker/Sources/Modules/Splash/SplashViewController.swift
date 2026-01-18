//
//  SplashViewController.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    var onFinish: (() -> Void)?
    
    // MARK: - UI Elements
    private let splashView = SplashView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ждем небольшую задержку для имитации загрузки
        // В реальности здесь можно инициализировать необходимые сервисы
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.onFinish?()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashView.startLoadingAnimation()
    }
}
