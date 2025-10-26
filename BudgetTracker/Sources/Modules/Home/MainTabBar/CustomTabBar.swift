//
//  MainTabBarController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

enum ConstantsTabBar {
    static let height: CGFloat = 83
    static let buttonHeight: CGFloat = 56
    static let activeLineHeight: CGFloat = 2
    static let horizontalPadding: CGFloat = 16
    static let interItemSpacing: CGFloat = 0
    static let centerButtonSize: CGFloat = 56
}

final class CustomTabBar: UIView {
    
    // MARK: - UI Elements
    private let stackView = UIStackView()
    private let activeLineView = UIView()
    private var buttons: [UIButton] = []
    private let centerButton = UIButton()
    
    // MARK: - Properties
    weak var delegate: CustomTabBarDelegate?
    private var activeTabIndex: Int = 0
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .appWhite
        
        // Stack View для кнопок
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = ConstantsTabBar.interItemSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Активная линия
        activeLineView.backgroundColor = .appBlack
        activeLineView.translatesAutoresizingMaskIntoConstraints = false
        
        // Центральная кнопка
        centerButton.backgroundColor = .systemPink
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white
        centerButton.layer.cornerRadius = ConstantsTabBar.centerButtonSize / 2
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        centerButton.layer.shadowRadius = 4
        centerButton.layer.shadowOpacity = 0.1
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        
        addSubview(stackView)
        addSubview(activeLineView)
        addSubview(centerButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Stack View
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: ConstantsTabBar.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -ConstantsTabBar.horizontalPadding),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: ConstantsTabBar.buttonHeight),
            
            // Центральная кнопка
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: topAnchor),
            centerButton.widthAnchor.constraint(equalToConstant: ConstantsTabBar.centerButtonSize),
            centerButton.heightAnchor.constraint(equalToConstant: ConstantsTabBar.centerButtonSize),
        ])
    }
    
    // MARK: - Public Methods
    func setTabTitles(_ titles: [String]) {
        // Очищаем старые кнопки
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        // Создаем новые кнопки
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.appDarkGray, for: .normal)
            button.setTitleColor(.appBlack, for: .selected)
            button.titleLabel?.font = UIFont.interMedium(size: 15)
            button.tag = index
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        // Устанавливаем первую кнопку как активную
        setActiveTab(0)
    }
    
    func setActiveTab(_ index: Int) {
        activeTabIndex = index
        
        // Обновляем состояния кнопок
        for (i, button) in buttons.enumerated() {
            button.isSelected = (i == index)
        }
        
        // Обновляем позицию активной линии
        UIView.animate(withDuration: 0.3) {
            self.updateActiveLinePosition()
        }
    }
    
    private func updateActiveLinePosition() {
        guard activeTabIndex < buttons.count else { return }
        
        let activeButton = buttons[activeTabIndex]
        let buttonWidth = activeButton.frame.width
        
        activeLineView.frame = CGRect(
            x: activeButton.frame.origin.x,
            y: 0,
            width: buttonWidth,
            height: ConstantsTabBar.activeLineHeight
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateActiveLinePosition()
    }
    
    // MARK: - Actions
    @objc private func tabButtonTapped(_ sender: UIButton) {
        let selectedIndex = sender.tag
        setActiveTab(selectedIndex)
        delegate?.didSelectTab(at: selectedIndex)
    }
    
    @objc private func centerButtonTapped() {
        delegate?.didTapCenterButton()
    }
}
