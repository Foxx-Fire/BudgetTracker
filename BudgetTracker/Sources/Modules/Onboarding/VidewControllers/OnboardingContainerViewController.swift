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
    var onFinish: (() -> Void)?
    
    // MARK: - Init
    
    init() {
        self.viewModel = OnboardingViewModel()
        // transitionStyle: .scroll - перелистывание страниц как в книгах
        // navigationOrientation: .horizontal - горизонтальная навигация (свайпы влево/вправо)
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
    
    // MARK: - Private Methods
    private func setupPages() {
        let pageViewControllers = (0..<viewModel.pageCount)
            .map { pageIndex in
            
            let сontentVC = OnboardingContentViewController(
                viewModel: viewModel,
                pageIndex: pageIndex
            )
            
                setupCallbacks(for: сontentVC) // ← использовать общий метод
                return сontentVC
            }
        
        if let firstPage = pageViewControllers.first {
            setViewControllers(
                [firstPage],
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
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingContentViewController,
              currentVC.pageIndex > 0 else { return nil }
        
        let newVC = OnboardingContentViewController(
            viewModel: viewModel,
            pageIndex: currentVC.pageIndex - 1
        )
        setupCallbacks(for: newVC)
        return newVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingContentViewController,
              currentVC.pageIndex < viewModel.pageCount - 1 else { return nil }
        
        let newVC = OnboardingContentViewController(
            viewModel: viewModel,
            pageIndex: currentVC.pageIndex + 1
        )
        setupCallbacks(for: newVC)
        return newVC
    }
    
    private func setupCallbacks(for contentVC: OnboardingContentViewController) {
        contentVC.onAction = { [weak self] in
            self?.onFinish?()
        }
        
        contentVC.onSkip = { [weak self] in
            self?.onFinish?()
        }
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first as? OnboardingContentViewController,
              let backgroundView = currentVC.view.subviews.first as? OnboardingBackgroundView else { return }
        
        // Обновить pageControl на текущей странице
        backgroundView.pageControl.currentPage = currentVC.pageIndex
    }
}
