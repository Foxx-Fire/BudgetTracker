//
//  DateFormatter+App.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

extension DateFormatter {
    static let transactionTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE h:mm a" // "Fri 10:30 AM"
        return formatter
    }()
    
    static let transactionDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" // "Oct 23, 2025"
        return formatter
    }()
}
