//
//  MainTabBarController.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import UIKit

enum ConstantsTabBar {
    static let height: CGFloat = 83
    static let buttonHeight: CGFloat = 60
    static let activeLineHeight: CGFloat = 2
    static let activeLineWidth: CGFloat = 26
    static let horizontalPadding: CGFloat = 16
    static let interItemSpacing: CGFloat = 0
    static let centerButtonSize: CGFloat = 56
}

final class CustomTabBar: UIView {
    
    // MARK: - UI Elements
    private let mainStackView = UIStackView()
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    private let centerButton = UIButton()
    
    // MARK: - Properties
    private var buttons: [UIButton] = []
    private var lines: [UIView] = []
    private var iconImageViews: [UIImageView] = []
    private var titleLabels: [UILabel] = []
    private var activeTabIndex: Int = 0
    var onTabSelected: ((Int) -> Void)? = nil
    var onCentralButtonTapped: (() -> Void)? = nil
    
    private let tabIcons: [String] = [
        "daily",          // Daily
        "stat",         // Stat
        "budget", // Budget
        "profile"             // Profile
    ]
    
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
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.spacing = 0
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Левый и правый стеки
        leftStackView.axis = .horizontal
        leftStackView.distribution = .fillEqually
        leftStackView.alignment = .fill
        leftStackView.spacing = 70
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        rightStackView.axis = .horizontal
        rightStackView.distribution = .fillEqually
        rightStackView.alignment = .fill
        rightStackView.spacing = 70
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Центральная кнопка
        centerButton.backgroundColor = .appPink
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white
        centerButton.layer.cornerRadius = ConstantsTabBar.centerButtonSize / 2
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        centerButton.layer.shadowRadius = 4
        centerButton.layer.shadowOpacity = 0.1
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.addAction(UIAction { [weak self] _ in
            self?.onCentralButtonTapped?()
        }, for: .touchUpInside)
        
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        addSubview(mainStackView)
        addSubview(centerButton)
    }
    
    private func createTabContainer(title: String, index: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let line = UIView()
        line.backgroundColor = .appPink
        line.layer.cornerRadius = 1.5
        line.translatesAutoresizingMaskIntoConstraints = false
        line.isHidden = true // изначально все линии скрыты
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: tabIcons[index])?.withRenderingMode(.alwaysTemplate)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.interRegular(size: 9)
        titleLabel.textColor = .appDarkGray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // ОДНА большая кнопка, которая покрывает всю область (иконку + текст)
        let button = UIButton(type: .custom)
        button.tag = index
        button.backgroundColor = .clear
        button.isOpaque = false
        button.addAction(UIAction { [weak self] _ in
            self?.setActiveTab(index)
            self?.onTabSelected?(index)
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(button)
        container.addSubview(line)
        container.addSubview(iconImageView)
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Кнопка покрывает ВСЮ область контейнера
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            button.topAnchor.constraint(equalTo: container.topAnchor),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            // Линия сверху (над иконкой)
            line.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            line.topAnchor.constraint(equalTo: container.topAnchor),
            line.widthAnchor.constraint(equalToConstant: 26),
            line.heightAnchor.constraint(equalToConstant: 3),
            
            // Иконка под линией
            iconImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 14),
            iconImageView.widthAnchor.constraint(equalToConstant: 23),
            iconImageView.heightAnchor.constraint(equalToConstant: 23),
            
            // Текст под иконкой
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        line.isUserInteractionEnabled = false
        iconImageView.isUserInteractionEnabled = false
        titleLabel.isUserInteractionEnabled = false
        
        buttons.append(button)
        lines.append(line)
        iconImageViews.append(iconImageView)
        titleLabels.append(titleLabel)
        
        return container
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ConstantsTabBar.horizontalPadding
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -ConstantsTabBar.horizontalPadding
            ),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: ConstantsTabBar.buttonHeight),
            
            // Центральная кнопка
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: topAnchor),             centerButton.widthAnchor.constraint(equalToConstant: ConstantsTabBar.centerButtonSize),
            centerButton.heightAnchor.constraint(equalToConstant: ConstantsTabBar.centerButtonSize)
        ])
    }
    
    // MARK: - Public Methods
    func setTabTitles(_ titles: [String]) {
        // Очищаем старые контейнеры и кнопки
        buttons.forEach { $0.removeFromSuperview() }
        lines.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        lines.removeAll()
        // Удаляем старые контейнеры из stackView
        leftStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        rightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Создаем контейнеры для каждой кнопки
        for (index, title) in titles.enumerated() {
            let container = createTabContainer(title: title, index: index)
            
            switch index {
            case 0, 1: // Daily, Stat - в левый стек
                leftStackView.addArrangedSubview(container)
            case 2, 3: // Budget, Profile - в правый стек
                rightStackView.addArrangedSubview(container)
            default:
                break
            }
        }
        
        // Устанавливаем первую кнопку как активную
        setActiveTab(0)
    }
    
    func setActiveTab(_ index: Int) {
        activeTabIndex = index // запоминаем какая кнопка активна
        
        // Простая логика: показываем линию только у активной кнопки
        for i in 0..<lines.count {
            let isActive = (i == index)
            lines[i].isHidden = !isActive
            iconImageViews[i].tintColor = isActive ? .appPink : .appLightGray
                titleLabels[i].textColor = isActive ? .appBlack : .appLightGray
        }
    }
}
