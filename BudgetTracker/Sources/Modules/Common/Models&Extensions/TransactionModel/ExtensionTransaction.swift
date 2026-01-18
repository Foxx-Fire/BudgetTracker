//
//  ExtensionTransaction.swift
//  BudgetTracker
//
//  Created by FoxxFire on 30.10.2025.
//

import Foundation

extension Transaction {
    var displayTime: String {
        // Если время пришло с бэка - используем его
        if let timeString = timeString, !timeString.isEmpty {
            return timeString
        }
        
        // Иначе вычисляем из даты
        if let date = DateFormatter.inputDate.date(from: self.date) {
            return DateFormatter.transactionTime.string(from: date)
        }
        
        return "Unknown time"
    }
    
    var displayDate: String {
        if let date = DateFormatter.inputDate.date(from: self.date) {
            return DateFormatter.transactionDate.string(from: date)
        }
        
        return "Unknown date"
    }
}

extension Transaction {
    static let transactionData: [Transaction] = [
        Transaction(
            id: "1",
            category: Category(id: "automobile", name: "automobile", icon: "automobile"),
            bank: Bank(id: "Tbank", bankName: "Tbank", bankIcon: "Tbank"),
            personName: "Gauthier Drewitt",
            date: "2024-01-02",
            timeString: "Fri 10:00 AM",
            currency: Currency(code: "", symbol: "", name: ""),
            amount: 340.40),
        
        Transaction(
            id: "2",
            category: Category(id: "eating", name: "eating", icon: "eating"),
            bank: Bank(id: "Sber", bankName: "Sber", bankIcon: "sber"),
            personName: "Sukhbirpal Dhalan",
            date: "2024-01-02",
            timeString: "Fri 10AM",
            currency: Currency(code: "", symbol: "", name: ""),
            amount: 120.90),
        
        Transaction(
            id: "3",
            category: Category(id: "others", name: "others", icon: "others"),
            bank: Bank(id: "Tbank", bankName: "Tbank", bankIcon: "Tbank"),
            personName: "Lia Castro",
            date: "2024-01-02",
            timeString: "Fri 10AM",
            currency: Currency(code: "", symbol: "", name: ""),
            amount: 145.30),
        
        Transaction(
            id: "4",
            category: Category(id: "medical", name: "medical", icon: "medical"),
            bank: Bank(id: "revolut", bankName: "revolut", bankIcon: "revolut"),
            personName: "Xu Xuefeng",
            date: "Fri 10AM",
            timeString: "Fri 10AM",
            currency: Currency(code: "", symbol: "", name: ""),
            amount: 180.32),
        
        Transaction(
            id: "5",
            category: Category(id: "medical", name: "medical", icon: "medical"),
            bank: Bank(id: "revolut", bankName: "revolut", bankIcon: "revolut"),
            personName: "Xu Xuefeng",
            date: "Fri 10AM",
            timeString: "Fri 10AM",
            currency: Currency(code: "", symbol: "", name: ""),
            amount: 420.10),
        
        Transaction(
            id: "6",
            category: Category(id: "medical", name: "medical", icon: "medical"),
            bank: Bank(id: "revolut", bankName: "revolut", bankIcon: "revolut"),
            personName: "Xu Xuefeng",
            date: "Fri 10AM",
            timeString: "Fri 10AM",
            currency: Currency(code: "", symbol: "", name: ""),
            amount: 420.10)
    ]
}
