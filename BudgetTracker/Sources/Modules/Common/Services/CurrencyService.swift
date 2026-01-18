//
//  CurrencyService.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//

import Foundation

protocol CurrencyServiceProtocol {
    func currency(for code: String) -> Currency?
    var availableCurrencies: [Currency] { get }
}


final class CurrencyService: CurrencyServiceProtocol {
    private let currencies: [String: Currency] = [
        "USD": .usd,
        "EUR": .eur,
        "GBP": .gbp,
        "JPY": .jpy,
        "RUB": .rub
    ]
    
    func currency(for code: String) -> Currency? {
        return currencies[code]
    }
    
    var availableCurrencies: [Currency] {
        return Array(currencies.values)
    }
}
