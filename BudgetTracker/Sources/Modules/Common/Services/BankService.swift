//
//  BankService.swift
//  BudgetTracker
//
//  Created by FoxxFire on 25.10.2025.
//
import UIKit

protocol BankServiceProtocol {
    var banks: [String: Bank] { get }
    var allBanks: [Bank] { get }
    func bank(for name: String) -> Bank?
    func bankName(for identifier: String) -> String
    func bankIcon(for identifier: String) -> String
}

final class BankService: BankServiceProtocol {
   
    let banks: [String: Bank] = [
        "tinkoff": .tinkoff,
        "sberBank": .sberBank,
        "revolut": .revolut,
        "n26": .n26
    ]
    
    func bank(for identifier: String) -> Bank? {
        return banks[identifier]
    }
    
    var allBanks: [Bank] {
        return Array(banks.values)
    }
    
    func bankName(for identifier: String) -> String {
        return banks[identifier]?.bankName ?? "Unknown Bank"
    }
    
    func bankIcon(for identifier: String) -> String {
        return banks[identifier]?.bankIcon ?? "building.columns"
    }
}
