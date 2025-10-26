//
//  CategoryServiceProtocol.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//
import Foundation

protocol CategoryServiceProtocol {
    var allCategories: [Category] { get }
    func category(for name: String) -> Category?
    func categoryName(for identifier: String) -> String
    func categoryIcon(for identifier: String) -> String
}
