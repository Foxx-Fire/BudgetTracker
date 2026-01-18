//
//  User.swift
//  Finance
//
//  Created by FoxxFire on 15.10.2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    var fullName: String
    let email: String
    let avatarImage: String?
    let creditScore: Int?
}

struct Account: Codable, Identifiable {
    let id: String
    let cardName: String
    let cardType: String
    var cardBalance: Int
    let currency: Currency 
    var isAvaliableToPay: Bool
}
