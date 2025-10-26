//
//  CustomTabBarController.swift
//  BudgetTracker
//
//  Created by FoxxFire on 27.10.2025.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func didSelectTab(at index: Int)
    func didTapCenterButton()
}


protocol CustomTabBarControllerDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

final class CustomTabBarController: UIViewController {
    
    // MARK: - UI Elements
    private let containerView = UIView()
    private let customTabBar = CustomTabBar()
    
    // MARK: - Properties
    private var viewControllers: [UIViewController] = []
    private var currentViewController: UIViewController?
    weak var delegate: CustomTabBarControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupTabBar()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .appBackground
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        view.addSubview(customTabBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container View (основной контент)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: customTabBar.topAnchor),
            
            // Custom TabBar
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: ConstantsTabBar.height)
        ])
    }
    
    private func setupTabBar() {
        customTabBar.delegate = self
    }
    
    private func showViewController(at index: Int) {
        guard index < viewControllers.count else { return }
        
        // Убираем текущий контроллер
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        
        // Добавляем новый контроллер
        let selectedVC = viewControllers[index]
        addChild(selectedVC)
        containerView.addSubview(selectedVC.view)
        selectedVC.view.frame = containerView.bounds
        selectedVC.didMove(toParent: self)
        
        currentViewController = selectedVC
        delegate?.didSelectTab(at: index)
    }
    
    // MARK: - Public Methods
    func setViewControllers(_ controllers: [UIViewController], animated: Bool) {
        viewControllers = controllers
        customTabBar.setTabTitles(controllers.compactMap { $0.tabBarItem?.title })
        
        // Показываем первый контроллер по умолчанию
        if !controllers.isEmpty {
            showViewController(at: 0)
        }
    }
    
    func setSelectedIndex(_ index: Int) {
        customTabBar.setActiveTab(index)
        showViewController(at: index)
    }
}

// MARK: - CustomTabBarDelegate
extension CustomTabBarController: CustomTabBarDelegate {
    func didSelectTab(at index: Int) {
        showViewController(at: index)
    }
    
    func didTapCenterButton() {
        // Обработка нажатия на центральную кнопку
        print("Center button tapped - show transaction creation")
    }
}
