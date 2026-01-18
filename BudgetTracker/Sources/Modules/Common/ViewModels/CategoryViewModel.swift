//
//  CategoryViewModel.swift
//  BudgetTracker
//
//  Created by FoxxFire on 24.10.2025.
//
import Foundation

protocol CategoryViewModelProtocol {
    var categoryCount: Int { get }
    func getCategory(for index: Int) -> Category
    func getCategory(for name: String) -> Category?
}


final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let categoryService: CategoryServiceProtocol
    private var categories: [Category] = []
    
    init(categoryService: CategoryServiceProtocol = CategoryService()) {
        self.categoryService = categoryService
        self.categories = categoryService.allCategories
    }
    
    var categoryCount: Int {
        categories.count
    }
    
    func getCategory(for index: Int) -> Category {
        guard index < categories.count else {
            return Category(id: "", name: "", icon: "")
        }
        return categories[index]
    }
    
    func getCategory(for name: String) -> Category? {
        return categoryService.category(for: name)
    }
}
