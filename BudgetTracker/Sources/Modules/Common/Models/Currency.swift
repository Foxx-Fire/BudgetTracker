//
//  Currency.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

struct Currency {
    let code: String
    let symbol: String
    let name: String
}

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
