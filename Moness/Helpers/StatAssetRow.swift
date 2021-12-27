//
//  StatAssetRow.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct StatAssetRow: View {
    var asset: AssetMethods.AssetResult
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 65)
            .foregroundColor(asset.color)
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Text(asset.symbol)
                            .font(.headline)
                        
                        Text(asset.methodName)
                            .font(.callout)
                            .opacity(0.6)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(formatToCurrency(amount: asset.profitLoss ,with: asset.currencySymbol))
                            .font(.headline)
                        
                        Text(formatToPercent(amount: asset.pctProfitLoss))
                            .font(.callout)
                            .opacity(0.6)
                            .lineLimit(1)
                    }
                }
                    .padding(.horizontal)
            )
    }
}

struct StatAssetRow_Previews: PreviewProvider {
    static var previews: some View {
        createView()
    }
    
    static private func createView() -> StatAssetRow {
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
        
        return StatAssetRow(
            asset: AssetMethods.AssetResult(
                methodName: "Apple Inc.",
                color: .green.opacity(0.1),
                symbol: "AAPL",
                profitLoss: 230.40,
                pctProfitLoss: 0.03,
                currencySymbol: "USD"
            )
        )
    }
}
