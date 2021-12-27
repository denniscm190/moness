//
//  PortfolioRow.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct PortfolioRow: View {
    var company: PortfolioCompany
    @State private var quote = QuoteResult(latestPrice: 0, changePercent: 0, change: 0)
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationLink(destination: CompanyDetails(company: company, latestPrice: quote.latestPrice)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(company.symbol!)
                        .font(.headline)
                    
                    Text(company.securityName ?? "-")
                        .font(.callout)
                        .opacity(0.6)
                        .lineLimit(1)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    HStack {
                        Text("\(formatToPercent(amount: quote.changePercent))")
                        
                        let closePrice = formatToCurrency(amount: quote.latestPrice, with: company.currency ?? "-")
                        Text("\(closePrice)")
                    }
                    .font(.headline)
                    .foregroundColor(getColor())
                    
                    Text("\(company.amount, specifier: "%.0f")")
                        .font(.callout)
                        .opacity(0.6)
                }
            }
        }
        .onAppear {
            getQuote()
            timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        }
        .onReceive(timer) { _ in
            getQuote()
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    
    // Return color given changePercent
    private func getColor() -> Color {
        if quote.changePercent >= 0 {
            return Color(.green)
        } else {
            return Color(.red)
        }
    }
    
    // Get quote data
    private func getQuote() {
        let url = "https://api.moness.app/stock/\(company.symbol!)/quote"
        httpRequest(url: url, model: QuoteResponse.self) { response in
            quote = response.message
        }
    }
}

struct PortfolioRow_Previews: PreviewProvider {
    static var previews: some View {
        createRow()
    }
    
    static private func createRow() -> PortfolioRow {
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
        
        return PortfolioRow(company: portfolioCompany)
    }
}
