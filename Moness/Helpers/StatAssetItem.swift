//
//  StatAssetItem.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct StatAssetItem: View {
    var asset: AssetMethods.AssetResult
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 200)
            .foregroundColor(asset.color)
            .opacity(0.1)
            .overlay(
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(asset.methodName) - \(asset.symbol)".uppercased())
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("\(formatToPercent(amount: asset.pctProfitLoss))")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(formatToCurrency(amount: asset.profitLoss, with: asset.currencySymbol))")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(asset.color)
                }
                .padding()
                , alignment: .leading)
    }
}

struct StatAssetItem_Previews: PreviewProvider {
    static var previews: some View {
        createView()
    }
    
    static private func createView() -> StatAssetItem {
        let context = PersistenceController.shared.container.viewContext
        let portfolioCompany = PortfolioCompany(context: context)
        portfolioCompany.symbol = "AAPL"
        portfolioCompany.cik = "0000320193"
        portfolioCompany.securityName = "Apple Inc"
        portfolioCompany.securityType = "cs"
        portfolioCompany.region = "US"
        portfolioCompany.exchange = "XNAS"
        portfolioCompany.sector = "Manufacturing"
        portfolioCompany.currency = "USD"
        portfolioCompany.purchasePrice = 120.30
        portfolioCompany.amount = 10
        
        return StatAssetItem(
            asset: AssetMethods.AssetResult(
                methodName: "Gainer",
                color: .green,
                symbol: "AAPL",
                profitLoss: 230.40,
                pctProfitLoss: 0.03,
                currencySymbol: "USD"
            )
        )
    }
}
