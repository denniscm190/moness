//
//  AddCompany.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct AddCompany: View {
    var company: SearchCompanyResult
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) private var companies: FetchedResults<PortfolioCompany>
    @State private var purchasePrice: Float = 0
    @State private var amount: Float = 0
    
    var body: some View {
        Form {
            
            let numberFormatter: NumberFormatter = {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                return formatter
            }()
            
            Section(header: Text("Add the purchase price")) {
                TextField("Purchase price", value: $purchasePrice, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Add the purchase amount")) {
                TextField("Purchase amount", value: $amount, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                if purchasePrice != 0 && amount != 0 {
                    Button("Done") {
                        add()
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("Add company")
    }
    
    // Add company to portfolio
    private func add() {
        let companySymbols = companies.map { $0.symbol }
        if companySymbols.contains(company.symbol) {
            // Update existing entry
            let portfolioCompany = companies.filter { $0.symbol == company.symbol }.first!
            let oldPrice = portfolioCompany.purchasePrice
            let oldAmount = portfolioCompany.amount
            let newPrice = (oldPrice * oldAmount + purchasePrice * amount) / (oldAmount + amount)
            portfolioCompany.purchasePrice = newPrice
            portfolioCompany.amount += amount
        } else {
            // Create new entry
            let portfolioCompany = PortfolioCompany(context: viewContext)
            portfolioCompany.symbol = company.symbol
            portfolioCompany.cik = company.cik
            portfolioCompany.securityName = company.securityName
            portfolioCompany.securityType = company.securityType
            portfolioCompany.region = company.region
            portfolioCompany.exchange = company.exchange
            portfolioCompany.sector = company.sector
            portfolioCompany.currency = company.currency
            portfolioCompany.purchasePrice = purchasePrice
            portfolioCompany.amount = amount
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddCompany_Previews: PreviewProvider {
    static var previews: some View {
        AddCompany(
            company:
                SearchCompanyResult(
                    symbol: "AAPL",
                    cik: "0000320193",
                    securityName: "Apple Inc",
                    securityType: "cs",
                    region: "US",
                    exchange: "XNAS",
                    sector: "Manufacturing",
                    currency: "USD"
                )
        )
    }
}
