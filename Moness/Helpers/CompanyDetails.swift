//
//  CompanyDetails.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct CompanyDetails: View {
    var company: PortfolioCompany
    @State var latestPrice: Float
    
    var body: some View {
        Form {
            let currencyCode = company.currency ?? "-"
            Section {
                CompanyDetailLabel(name: "Symbol", value: Text(company.symbol!))
                CompanyDetailLabel(name: "Security name", value: Text(company.securityName ?? "-"))
                CompanyDetailLabel(name: "CIK", value: Text(company.cik ?? "-"))
                CompanyDetailLabel(name: "Region", value: Text(company.region ?? "-"))
                CompanyDetailLabel(name: "Currency", value: Text(currencyCode))
                CompanyDetailLabel(name: "Exchange", value: Text(company.exchange ?? "-"))
                CompanyDetailLabel(name: "Sector", value: Text(company.sector ?? "-"))
            }
            
            let amount = company.amount
            let purchasePrice =  company.purchasePrice
            let formattedPurchasePrice = formatToCurrency(amount: purchasePrice, with: currencyCode)
            let costValue = purchasePrice * amount
            let formattedCostValue = formatToCurrency(amount: costValue, with: currencyCode)
            Section {
                CompanyDetailLabel(name: "Amount in portfolio", value: Text("\(amount, specifier: "%.4f")"))
                CompanyDetailLabel(name: "Avg. purchase price", value: Text("\(formattedPurchasePrice)"))
                CompanyDetailLabel(name: "Avg. cost value", value: Text(formattedCostValue))
            }
            
            let marketValue = latestPrice * amount
            let formattedMarketValue = formatToCurrency(amount: marketValue, with: currencyCode)
            let profitLoss = formatToCurrency(amount: marketValue - costValue, with: currencyCode)
            Section {
                CompanyDetailLabel(name: "Latest price", value: Text("\(latestPrice, specifier: "%.2f")"))
                CompanyDetailLabel(name: "Market value", value: Text("\(formattedMarketValue)"))
                CompanyDetailLabel(name: "Profit / Loss", value: Text("\(profitLoss)"))
            }
        }
        .navigationTitle("Details")
    }
}

struct CompanyDetails_Previews: PreviewProvider {
    static var previews: some View {
        createView()
    }
    
    static private func createView() -> CompanyDetails {
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
        
        return CompanyDetails(company: portfolioCompany, latestPrice: 120.30)
    }
}
