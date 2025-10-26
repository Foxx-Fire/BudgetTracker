//
//  BankService.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//
import Foundation

final class BankService: BankServiceProtocol {
    let banks: [String: Banks] = [
        "tinkoff": .tinkoff,
        "sberBank": .sberBank,
        "revolut": .revolut,
        "n26": .n26
    ]
    
    func bank(for identifier: String) -> Banks? {
        return banks[identifier]
    }
    
    var allBanks: [Banks] {
        return Array(banks.values)
    }
    
    func bankName(for identifier: String) -> String {
        return banks[identifier]?.bankName ?? "Unknown Bank"
    }
    
    func bankIcon(for identifier: String) -> String {
        return banks[identifier]?.bankIcon ?? "building.columns"
    }
}
