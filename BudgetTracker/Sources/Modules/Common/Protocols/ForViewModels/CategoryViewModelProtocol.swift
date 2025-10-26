//
//  CategorySelectionViewModelDelegate.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//

protocol CategoryViewModelProtocol {
    var categoryCount: Int { get }
    func getCategory(for index: Int) -> Category
    func getCategory(for name: String) -> Category?
}
