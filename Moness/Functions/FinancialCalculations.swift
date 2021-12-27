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

    func getSortedCompanies(from companies: FetchedResults<PortfolioCompany>, given quotes: [String: QuoteResult]) -> [AssetResult] {
        var sortedCompanies = [AssetResult]()
        for company in companies {
            let latestPrice = quotes[company.symbol!]?.latestPrice ?? 0
            let profitLoss = (latestPrice - company.purchasePrice) * company.amount
            let pctProfitLoss = profitLoss / (company.purchasePrice * company.amount)
            
            sortedCompanies.append(
                AssetResult(
                    methodName: company.securityName ?? "-",
                    color: Color(.secondarySystemBackground),
                    symbol: company.symbol!,
                    profitLoss: profitLoss,
                    pctProfitLoss: pctProfitLoss,
                    currencySymbol: company.currency ?? ""
                )
            )
        }
        
        sortedCompanies.sort { $0.pctProfitLoss > $1.pctProfitLoss }
        
        return sortedCompanies
    }
    
    struct AssetResult: Hashable {
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
        var marketValues = [Float]()
        var changeValues = [Float]()
        
        for company in companies {
            let latestPrice = quotes[company.symbol!]?.latestPrice ?? 0
            let change = quotes[company.symbol!]?.change ?? 0
            marketValues.append(company.amount * latestPrice)
            changeValues.append(company.amount * change)
        }
        
        let marketValue = marketValues.reduce(0, +)
        let changeValue = changeValues.reduce(0, +)

        let pctChange = changeValue / (marketValue - changeValue)
        
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
        var profitLossValues = [Float]()
        var investmentValues = [Float]()
        
        for company in companies {
            let latestPrice = quotes[company.symbol!]?.latestPrice ?? 0
            profitLossValues.append((latestPrice - company.purchasePrice) * company.amount)
            investmentValues.append(company.amount * company.purchasePrice)
        }
        
        let profitLoss = profitLossValues.reduce(0, +)
        let investment = investmentValues.reduce(0, +)
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
