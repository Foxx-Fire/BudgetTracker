//
//  OnboardingPageViewController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

final class OnboardingContentViewController: UIViewController {
    
    // MARK: - Properties
    private let pageView: OnboardingPageView
    private let viewModel: OnboardingViewModelProtocol
    var pageControl: CustomPageControl {
        return pageView.pageControl
    }
  
    var onAction: (() -> Void)?
    var onSkip: (() -> Void)?
    
    // MARK: - Init
    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        self.pageView = OnboardingPageView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = pageView
    }
    
    //    Когда configure вызывается?
    //    
    //    ✅ viewDidLoad - самый частый случай
    //    ✅ init - если данные известны сразу    
    //    ✅ didSet - если данные приходят позже
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewCallbacks()
    }
    
    func setupPageViewCallbacks() {
        pageView.onAction = { [weak self] in
            self?.onAction?()
        }
        
        pageView.onSkip = { [weak self] in
            self?.onSkip?()
        }
    }
    
    func configure(for index: Int) {
        let backgroundModel = viewModel.getBackgroundModel(for: index)
        let contentModel = viewModel.getContentModel(for: index)
        
        setupPageViewCallbacks()
        
        pageView.configure(
            backgroundImageName: backgroundModel.backgroundImageName,
            currentPage: index,
            totalPages: viewModel.pageCount,
            cardTitle: contentModel?.title,
            cardDescription: contentModel?.description
        )
    }
}
