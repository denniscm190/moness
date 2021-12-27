//
//  Formatters.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import Foundation

// MARK: - Get number formatted as currency
func formatToCurrency(amount: Float, with currencyCode: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = currencyCode
    formatter.locale = Locale(identifier: "en_US")
    
    return formatter.string(from: NSNumber(value: amount)) ?? "\(amount) \(currencyCode)"
}

// MARK: - Get number formatted as percent
func formatToPercent(amount: Float) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    formatter.maximumFractionDigits = 2
    
    return formatter.string(from: NSNumber(value: amount))!
}
