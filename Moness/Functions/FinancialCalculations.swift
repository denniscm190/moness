//
//  FinancialCalculations.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 25/12/21.
//

import SwiftUI

// MARK: - ASSET METHODS
struct AssetMethods {
    // Extract asset from portfolio given a condition

    func getMostProfitableAsset(from companies: FetchedResults<PortfolioCompany>, given quotes: [String: QuoteResult]) -> AssetResult {
        let sortedCompanies = companies.sorted {
            (quotes[$0.symbol!]!.latestPrice - $0.purchasePrice) * $0.amount / ($0.purchasePrice * $0.amount) > (
                quotes[$0.symbol!]!.latestPrice - $1.purchasePrice) * $1.amount / ($1.purchasePrice * $1.amount)
        }
        
        let company = sortedCompanies.first!
        let profitLoss = (quotes[company.symbol!]!.latestPrice - company.purchasePrice) * company.amount
        let pctProfitLoss = profitLoss / (company.purchasePrice * company.amount)
        
        return AssetResult(
            methodName: "Best",
            color: .green,
            symbol: company.symbol!,
            profitLoss: profitLoss,
            pctProfitLoss: pctProfitLoss,
            currencySymbol: company.currency ?? ""
        )
    }
    
    func getLessProfitableAsset(from companies: FetchedResults<PortfolioCompany>, given quotes: [String: QuoteResult]) -> AssetResult {
        let sortedCompanies = companies.sorted {
            (quotes[$0.symbol!]!.latestPrice - $0.purchasePrice) * $0.amount / ($0.purchasePrice * $0.amount) < (
                quotes[$0.symbol!]!.latestPrice - $1.purchasePrice) * $1.amount / ($1.purchasePrice * $1.amount)
        }
        
        let company = sortedCompanies.first!
        let profitLoss = (quotes[company.symbol!]!.latestPrice - company.purchasePrice) * company.amount
        let pctProfitLoss = profitLoss / (company.purchasePrice * company.amount)
        
        return AssetResult(
            methodName: "Worst",
            color: .red,
            symbol: company.symbol!,
            profitLoss: profitLoss,
            pctProfitLoss: pctProfitLoss,
            currencySymbol: company.currency ?? ""
        )
    }
    
    struct AssetResult {
        var methodName: String
        var color: Color
        var symbol: String
        var profitLoss: Float
        var pctProfitLoss: Float
        var currencySymbol: String
    }
}

// MARK: - STATS METHODS
struct StatsMethods {
    // Compute a certain statistic from the portfolio
    
    func getMarketValue(from companies: FetchedResults<PortfolioCompany>, given quotes: [String: QuoteResult]) -> StatResult {
        let marketValue = companies.map { $0.amount * quotes[$0.symbol!]!.latestPrice }.reduce(0, +)
        let change = companies.map { $0.amount * quotes[$0.symbol!]!.change }.reduce(0, +)
        let pctChange = change / (marketValue - change)
        
        return StatResult(
            methodName: "Market value",
            color: .orange,
            value: marketValue,
            pctValue: pctChange,
            lowSymbol: "arrowtriangle.down.fill",
            highSymbol: "arrowtriangle.up.fill"
        )
    }
    
    func getRoi(from companies: FetchedResults<PortfolioCompany>, given quotes: [String: QuoteResult]) -> StatResult {
        let profitLoss = companies.map { (quotes[$0.symbol!]!.latestPrice - $0.purchasePrice) * $0.amount }.reduce(0, +)
        let investment = companies.map { $0.amount * $0.purchasePrice }.reduce(0, +)
        let roi = profitLoss / investment
        
        return StatResult(
            methodName: "ROI",
            color: .blue,
            value: profitLoss,
            pctValue: roi,
            lowSymbol: "chart.line.uptrend.xyaxis",
            highSymbol: "chart.line.uptrend.xyaxis"
        )
    }
    
    struct StatResult {
        var methodName: String
        var color: Color
        var value: Float
        var pctValue: Float
        var lowSymbol: String
        var highSymbol: String
    }
}

// HELPERS (Supply functions above)
// MARK: - Get average cost per share
/*
 
*/
func getAverageCostPerShare(with symbol: String) {
    
}
