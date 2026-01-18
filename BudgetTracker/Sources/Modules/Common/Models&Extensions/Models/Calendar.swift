//
//  Calendar.swift
//  BudgetTracker
//
//  Created by FoxxFire on 30.10.2025.
//
import Foundation

struct CalendarMonth: Codable {
    let month: String
    let year: Int
    let weeks: [CalendarWeek]
}

struct CalendarWeek: Codable {
    let days: [CalendarDay]
}

struct CalendarDay: Codable, Identifiable {
    let id: String
    let day: Int
    let isCurrentMonth: Bool
    let isSelected: Bool
    let date: String
    let hasTransactions: Bool
}
