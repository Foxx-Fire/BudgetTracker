//
//  CurrencyFormatter.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

enum CurrencyFormatter {
    static func format(amount: Double, currency: Currency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency.symbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
}
