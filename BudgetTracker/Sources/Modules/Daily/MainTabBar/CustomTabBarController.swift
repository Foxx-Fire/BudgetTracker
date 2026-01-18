//
//  CustomTabBarController.swift
//  BudgetTracker
//
//  Created by FoxxFire on 27.10.2025.
//

import UIKit

final class CustomTabBarController: UIViewController {
    
    // MARK: - UI Elements
    private let containerView = UIView()
    private let customTabBar = CustomTabBar()
    
    // MARK: - Properties
    private var viewControllers: [UIViewController] = []
    private var currentViewController: UIViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
        setupConstraints()
        setupTabBarWithViewControllers()
        setupTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Обновляем frame когда layout готов
        currentViewController?.view.frame = containerView.bounds
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
    
    func setupTabBarWithViewControllers() {
        
        let dailyVC = DailyViewController()
        let dailyNavController = UINavigationController(rootViewController: dailyVC)
        dailyNavController.setNavigationBarHidden(true, animated: false)
        dailyNavController.tabBarItem.title = "Daily"
        
        let statVC = UIViewController()
        let statNavController = UINavigationController(rootViewController: statVC)
        statNavController.setNavigationBarHidden(true, animated: false)
        statNavController.tabBarItem.title = "Stat"
        
        let budgetVC = UIViewController()
        let budgetNavController = UINavigationController(rootViewController: budgetVC)
        budgetNavController.setNavigationBarHidden(true, animated: false)
        budgetNavController.tabBarItem.title = "Budget"
        
        let profileVC = UIViewController()
        let profileNavController = UINavigationController(rootViewController: profileVC)
        profileNavController.setNavigationBarHidden(true, animated: false)
        profileNavController.tabBarItem.title = "Profile"
        
        viewControllers = [
            dailyNavController,
            statNavController,
            budgetNavController,
            profileNavController
        ]
        
        customTabBar.setTabTitles(viewControllers.compactMap { $0.tabBarItem?.title })
        setSelectedIndex(0)
    }
    // Проблема: Кнопки находятся в CustomTabBar, но переключение экранов должно происходить в CustomTabBarController.
    // Решение: Используем "передачу сообщений" через замыкания:
    // [weak self] - это как сказать: "Если меня не станет (контроллер закроется), не пытайся меня звать - это вызовет ошибку"
    private func setupTabBar() {
        // Говорим таббару: "Когда кто-то нажмет на кнопку таба - позови меня!"
        customTabBar.onTabSelected = { [weak self] index in
            self?.showViewController(at: index) // я покажу нужный экран
        }
            // Говорим таббару: "Когда нажмут на центральную кнопку - дай мне знать!"
            customTabBar.onCentralButtonTapped = {
            }
    }
    
    // "Переключить канал"
    private func showViewController(at index: Int) {
        guard index < viewControllers.count else { return }
        
        // 1. ВЫКЛЮЧАЕМ текущий канал:
        // "Ребенок уходит из семьи"
        currentViewController?.willMove(toParent: nil)  // "Сейчас уйду!"
        currentViewController?.view.removeFromSuperview() // Убираем с экрана
        currentViewController?.removeFromParent() // Отсоединяем
      
        // 2. ВКЛЮЧАЕМ новый канал:
        // Добавляем новый контроллер
        let selectedVC = viewControllers[index] // Берем нужный контроллер
        // CustomTabBarController говорит: "Ты теперь мой ребенок"
        addChild(selectedVC)
        containerView.addSubview(selectedVC.view) // Добавляем на экран
        // "Ребенок говорит: Я теперь живу у нового родителя!"
        selectedVC.didMove(toParent: self) // "Я на месте!"
     
        // 3. ЗАПОМИНАЕМ что сейчас показываем:
        currentViewController = selectedVC
    }
    
    // MARK: - Public Methods
    /*Аналогия:
    
    Даем пульту список каналов: ["Первый", "НТВ", "ТНТ", "СТС"]
    
    На кнопках пульта пишем эти названия
    
    Включаем первый канал
     */
    // "Настроить список каналов"
    func setViewControllers(
        _ controllers: [UIViewController],
        animated: Bool
    ) {
        viewControllers = controllers // Запоминаем все "каналы" (экраны)
        // Берем названия кнопок из контроллеров:
        customTabBar.setTabTitles(controllers.compactMap { $0.tabBarItem?.title })
        
        // Показываем первый контроллер по умолчанию
        if !controllers.isEmpty {
            showViewController(at: 0)
            customTabBar.setActiveTab(0)
        }
    }
    
    // "Нажать кнопку на пульте"
    func setSelectedIndex(_ index: Int) {
        customTabBar.setActiveTab(index) // Подсветить кнопку на пульте
        showViewController(at: index) // Переключить канал
    }
}


