//
//  CurrencyExtension.swift
//  BudgetTracker
//
//  Created by FoxxFire on 31.10.2025.
//


extension Currency {
    static let usd = Currency(
        code: "USD",
        symbol: "$",
        name: "US Dollar"
    )
    
    static let eur = Currency(
        code: "EUR",
        symbol: "€",
        name: "Euro"
    )
    
    static let gbp = Currency(
        code: "GBP",
        symbol: "£",
        name: "British Pound"
    )
    
    static let jpy = Currency(
        code: "JPY",
        symbol: "¥",
        name: "Japanese Yen"
    )
    
    static let rub = Currency(
        code: "RUB",
        symbol: "₽",
        name: "Russian Ruble"
    )
}
