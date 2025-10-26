//
//  Banks.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//
import Foundation

struct Banks {
    let bankName: String
    let bankIcon: String
}
                    
extension Banks {
    static let tinkoff = Banks(
        bankName: "T-bank",
        bankIcon: "Tbank"
    )
    
    static let sberBank = Banks(
        bankName: "Сбербанк",
        bankIcon: "sber"
    )
    
    static let revolut = Banks(
        bankName: "Revolut",
        bankIcon: "revolut"
    )
    
    static let n26 = Banks(
        bankName: "B2",
        bankIcon: "N26"
    )
}


