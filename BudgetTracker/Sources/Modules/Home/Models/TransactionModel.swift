//
//  HomeModel.swift
//  BudgetTracker
//
//  Created by FoxxFire on 23.10.2025.
//
import Foundation

struct Transaction {
    let id: String
    let category: String
    let bank: String
    let personName: String
    let date: Date
    let timeString: String
    let currency: String 
    let amount: Double
}

extension Transaction {
    static let transactionData: [Transaction] = [
        Transaction(
            id: "1",
            category: "eating",
            bank: "tinkoff",
            personName: "Gauthier Drewitt",
            date: Date(),
            timeString: "Fri 10AM",
            currency: "usd",
            amount: 340.40),
        
        Transaction(
            id: "2",
            category: "eating",
            bank: "sberBank",
            personName: "Sukhbirpal Dhalan",
            date: Date(),
            timeString: "Fri 10AM",
            currency: "usd",
            amount: 340.40),
        
        Transaction(
            id: "3",
            category: "others",
            bank: "tinkoff",
            personName: "Lia Castro",
            date: Date(),
            timeString: "Fri 10AM",
            currency: "usd",
            amount: 340.40),
        
        Transaction(
            id: "4",
            category: "medical",
            bank: "revolut",
            personName: "Xu Xuefeng",
            date: Date(),
            timeString: "Fri 10AM",
            currency: "usd",
            amount: 340.40),
        
        Transaction(
            id: "5",
            category: "medical",
            bank: "revolut",
            personName: "Xu Xuefeng",
            date: Date(),
            timeString: "Fri 10AM",
            currency: "usd",
            amount: 340.40)
    ]
}
