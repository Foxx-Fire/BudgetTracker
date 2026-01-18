//
//  Date+Format.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

extension DateFormatter {
    // Форматтер для ВХОДЯЩЕЙ даты (то, что приходит в JSON)
    static let inputDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // формат твоей даты в модели
        return formatter
    }()
    
    // Форматтер для ИСХОДЯЩЕГО времени (то, что показываем в UI)
    static let transactionTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE h:mm a" // "Fri 10:30 AM"
        return formatter
    }()
    
    // Форматтер для ИСХОДЯЩЕЙ даты (то, что показываем в UI)
    static let transactionDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" // "Oct 23, 2025"
        return formatter
    }()
}
