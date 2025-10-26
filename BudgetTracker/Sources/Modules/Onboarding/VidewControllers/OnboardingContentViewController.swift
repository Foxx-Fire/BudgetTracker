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
    let pageIndex: Int
    
    var onAction: (() -> Void)?
    var onSkip: (() -> Void)?
    
    // MARK: - Init
    init(viewModel: OnboardingViewModelProtocol, pageIndex: Int) {
        self.viewModel = viewModel
        self.pageView = OnboardingPageView()
        self.pageIndex = pageIndex
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
      
        let backgroundModel = viewModel.getBackgroundModel(for: pageIndex)
        let contentModel = viewModel.getContentModel(for: pageIndex)
        
        pageView.onAction = { [weak self] in
            self?.onAction?() // ← Передаем нажатие дальше
        }
        
        pageView.onSkip = { [weak self] in
            self?.onSkip?() // ← Передаем нажатие дальше
        }
        
        pageView.configure(
            backgroundImageName: backgroundModel.backgroundImageName,
            currentPage: pageIndex,
            totalPages: viewModel.pageCount,
            cardTitle: contentModel?.title,
            cardDescription: contentModel?.description
        )
    }
}
