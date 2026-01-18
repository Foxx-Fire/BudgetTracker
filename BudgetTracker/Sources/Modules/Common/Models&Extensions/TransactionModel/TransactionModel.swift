//
//  HomeModel.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//
import Foundation

enum TransactionType: String, Codable {
    case income = "Income"
    case expense = "Expense"
}

struct Transaction: Codable, Identifiable {
    let id: String
   // let selectedDate: String
   // let calendar: CalendarMonth
   // let transactions: [Transaction]
    let category: Category
    let bank: Bank
    let personName: String
    let date: String
    let timeString: String?
    let currency: Currency
    let amount: Double
  //  let totalAmount: Double
}

struct AddTransactionRequest: Codable, Identifiable {
    let id: String
    let payee: String
    let amount: Double
    let currency: String
    let date: String
    let timeString: String
    let transactionType: TransactionType
}

// для congatulations
struct AddTransactionResponse: Codable {
    let success: Bool
    let transaction: Transaction?
    let message: String?
}

// подсчет трат
struct TransactionSummary: Codable {
    let totalIncome: Double
    let totalExpenses: Double
    let netAmount: Double
    let currency: String
}

