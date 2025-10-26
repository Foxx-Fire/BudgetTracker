//
//  CategoryService.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//
import Foundation

final class CategoryService: CategoryServiceProtocol {
    
        private let categories: [String: Category] = [
            "automobile": .automobile,
            "bank": .bank,
            "cash": .cash,
            "charity": .charity,
//            "childcare": .childcare,
//            "shopping": .shopping,
//            "company": .company,
//            "creditCard": .creditCard,
            "eating": .eating,
//            "education": .education,
//            "entertainment": .entertainment,
//            "furniture": .furniture,
//            "gadget": .gadget,
//            "gift": .gift,
//            "groceries": .groceries,
//            "fitness": .fitness,
//            "loan": .loan,
            "medical": .medical,
//            "misc": .misc,
//            "office": .office,
            "others": .others,
//            "pets": .pets,
//            "property": .property,
//            "rent": .rent,
//            "savings": .savings,
//            "tax": .tax,
//            "transport": .transport,
//            "travel": .travel,
//            "utilities": .utilities,
//            "custom": .custom
        ]
    
        func category(for identifier: String) -> Category? {
            return categories[identifier]
        }
    
    var allCategories: [Category] {
        return Array(categories.values)
    }
    
    func categoryName(for identifier: String) -> String {
        return categories[identifier]?.name ?? "Unknown Category"
    }
    
    func categoryIcon(for identifier: String) -> String {
        return categories[identifier]?.icon ?? "questionmark"
    }
}
