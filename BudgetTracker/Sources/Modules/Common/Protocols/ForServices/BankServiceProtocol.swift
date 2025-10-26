//
//  BankServiceProtocol.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//
import Foundation

protocol BankServiceProtocol {
    var banks: [String: Banks] { get }
    var allBanks: [Banks] { get }
    func bank(for name: String) -> Banks?
    func bankName(for identifier: String) -> String
    func bankIcon(for identifier: String) -> String
}
