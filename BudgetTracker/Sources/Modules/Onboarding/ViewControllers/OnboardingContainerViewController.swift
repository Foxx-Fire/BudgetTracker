//
//  OnboardingViewController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//


/*
 OnboardingViewController - это UIPageViewController, который переключает между:
 
 OnboardingPageViewController(page1)
 
 OnboardingPageViewController(page2)
 
 OnboardingPageViewController(page3)
 */


import UIKit

final class OnboardingContainerViewController: UIPageViewController {
    
    // MARK: - Properties
    private let viewModel: OnboardingViewModelProtocol
    private var pages: [OnboardingContentViewController] = []
    var onFinish: (() -> Void)?
    
    // MARK: - Init
    
    init() {
        self.viewModel = OnboardingViewModel()
        // transitionStyle: .scroll - перелистывание страниц как в книгах
        // navigationOrientation: .horizontal - горизонтальная навигация (свайпы влево/вправо)
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPages()
        setupAppearance()
    }
    
    /*
     pages = []  // Создаем пустой массив
     
     // Проходим по всем номерам страниц от 0 до (viewModel.pageCount - 1)
     for pageIndex in 0..<viewModel.pageCount {
     // Создаем контроллер для текущей страницы
     let contentVC = OnboardingContentViewController(
     viewModel: viewModel,
     pageIndex: pageIndex
     )
     
     // Настраиваем колбэки
     setupCallbacks(for: contentVC)
     
     // Добавляем в массив результатов
     pages.append(contentVC)
     }
     */
    
    // MARK: - Private Methods
    private func setupPages() {
        pages = (0..<viewModel.pageCount)
            .map { pageIndex in
                
                let сontentVC = OnboardingContentViewController(
                    viewModel: viewModel
                )
                сontentVC.configure(for: pageIndex)
                setupCallbacks(for: сontentVC)
                return сontentVC
            }
        
        if let startPage = pages.first {
            setViewControllers(
                [startPage],
                direction: .forward,
                animated: true
            )
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = .appBackground
    
        dataSource = self
        delegate = self
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingContentViewController else { return nil }
        
        if let index = pages.firstIndex(of: currentVC ) {
            if index > 0 {
                setupCallbacks(for: currentVC)
                return pages[index - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingContentViewController else { return nil }
        
        if let index = pages.firstIndex(of: currentVC ) {
            if index < pages.count - 1 {
                setupCallbacks(for: currentVC)
                return pages[index + 1]
            }
        }
        
        return nil
    }
    
    private func setupCallbacks(for contentVC: OnboardingContentViewController) {
        contentVC.onAction = { [weak self] in
            self?.onFinish?()
        }
        
        contentVC.onSkip = { [weak self] in
            self?.onFinish?()
        }
        
        contentVC.setupPageViewCallbacks()
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    // Вызывается КОГДА АНИМАЦИЯ ПЕРЕЛИСТЫВАНИЯ ЗАКОНЧИЛАСЬ
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        // какие страницы были ДО перелистывания
        previousViewControllers: [UIViewController],
        //перелистывание успешно завершено (true) или отменено (false)
        transitionCompleted completed: Bool
    ) {
        guard completed,
              let currentVC = pageViewController.viewControllers?.first as? OnboardingContentViewController,
              let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        
        // Обновить pageControl на текущей странице
        currentVC.pageControl.currentPage = currentIndex
        currentVC.pageControl.numberOfPages = viewModel.pageCount
    }
}
