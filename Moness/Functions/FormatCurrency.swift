//
//  FormatCurrency.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import Foundation

// Format currency given currency code and amount
func format(amount: Float, with currencyCode: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = currencyCode
    
    return formatter.string(from: NSNumber(value: amount)) ?? "\(amount) \(currencyCode)"
}
