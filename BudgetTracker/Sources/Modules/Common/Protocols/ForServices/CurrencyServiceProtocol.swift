//
//  CurrencyServiceProtocol.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//
import Foundation

protocol CurrencyServiceProtocol {
    func currency(for code: String) -> Currency?
    var availableCurrencies: [Currency] { get }
}
