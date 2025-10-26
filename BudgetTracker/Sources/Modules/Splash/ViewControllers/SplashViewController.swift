//
//  SplashViewController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: SplashViewModelProtocol
    
    // колбэк (замыкание), которое говорит: "Когда экран закончит свою работу - выполни этот код".
    var onFinish: (() -> Void)? // // ← "Сообщи КООРДИНАТОРУ когда я закончу"
    // Когда-нибудь потом мы вызовем:
    // onFinish?() - и координатор узнает, что пора переходить дальше
    // В AppCoordinator
    //  self?.showOnboarding()  // ← "Когда сплеш закончится - покажи онбординг"
    
    // MARK: - Init
    
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = SplashView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splashView = view as? SplashView {
            splashView.configure(
                with: viewModel.splashModel.splashImageName,
                title: viewModel.splashModel.splashLabel
            )
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Имитация загрузки
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.onFinish?() // ← ВЫЗОВИ onFinish КОГДА SPLASH ЗАКОНЧИТСЯ
        }
    }
}
