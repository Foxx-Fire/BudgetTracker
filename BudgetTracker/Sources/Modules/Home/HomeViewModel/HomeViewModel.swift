//
//  HomeViewModel.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    var formattedTotal: String { get }
    var transactionCount: Int { get }
    func getTransaction(for index: Int) -> Transaction
    func getCategoryIconName(for transaction: Transaction) -> String
    func getBankIconName(for transaction: Transaction) -> String
    func getFormattedAmount(for transaction: Transaction) -> String
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let categoryService: CategoryServiceProtocol
    private let bankService: BankServiceProtocol
    private let currencyService: CurrencyServiceProtocol
    let transactions: [Transaction] = Transaction.transactionData
    
    init(
        categoryService: CategoryServiceProtocol = CategoryService(),
        bankService: BankServiceProtocol = BankService(),
        currencyService: CurrencyServiceProtocol = CurrencyService()
    ) {
        self.categoryService = categoryService
        self.bankService = bankService
        self.currencyService = currencyService
    }
    
    var formattedTotal: String {
        let total = transactions.reduce(0) { $0 + $1.amount }
        let currencyCode = transactions.first?.currency ?? "USD"
        let currency = currencyService.currency(for: currencyCode) ?? .usd
        return CurrencyFormatter.format(amount: total, currency: currency)
    }
    
    func getFormattedAmount(for transaction: Transaction) -> String {
        let currency = currencyService.currency(for: transaction.currency) ?? .usd
        return CurrencyFormatter.format(amount: transaction.amount, currency: currency)
    }
    
    var transactionCount: Int {
        transactions.count
    }
    
    func getTransaction(for index: Int) -> Transaction {
        guard index < transactions.count else {
            fatalError("Index out of range")
        }
        return transactions[index]
    }
           
    func getCategoryIconName(for transaction: Transaction) -> String {
        let categoryName = transaction.category
        let foundCategory = categoryService.category(for: categoryName)
        let iconName = foundCategory?.icon ?? "questionmark"
       
        return iconName
    }
    
    func getBankIconName(for transaction: Transaction) -> String {
    
        return bankService.bankIcon(for: transaction.bank)
    }
}
