//
//  StatsView.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI
import CoreData

struct StatsView: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var companies: FetchedResults<PortfolioCompany>
    
    // API request
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var quotes: [String: QuoteResult] = ["": QuoteResult(latestPrice: 0, changePercent: 0, change: 0)]
    @State private var showingStats = false
    
    // Financial calculations
    let assetMethods = AssetMethods()
    let statsMethods = StatsMethods()
    
    var body: some View {
        VStack {
            if companies.isEmpty {
                StatsPlaceholder()
            } else {
                ScrollView {
                    if showingStats {
                        VStack(spacing: 10) {
                            HStack {
                                let marketValue = statsMethods.getMarketValue(from: companies, given: quotes)
                                StatPortfolioItem(stat: marketValue)
                                
                                let roi = statsMethods.getRoi(from: companies, given: quotes)
                                StatPortfolioItem(stat: roi)
                            }

                            let sortedCompanies = assetMethods.getSortedCompanies(from: companies, given: quotes)
                            ForEach(sortedCompanies, id: \.self) { asset in
                                StatAssetRow(asset: asset)
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        ProgressView()
                    }
                }
                .onAppear {
                    getBatchQuote()
                    timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                }
                .onReceive(timer) { _ in
                    getBatchQuote()
                }
                .onDisappear {
                    timer.upstream.connect().cancel()
                }
            }
        }
        .navigationTitle("Stats")
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
    // Make batch request
    private func getBatchQuote() {
        let symbols = companies.map { $0.symbol! }
        let symbolString = symbols.joined(separator: ",")
        let url = "https://api.simoleon.app/stock/market/batch?symbols=\(symbolString)&types=quote"
        httpRequest(url: url, model: QuoteBatchResponse.self) { response in
            for symbol in symbols {
                let quote = response.message[symbol.uppercased()]!.quote
                quotes[symbol] = quote
            }
            
            showingStats = true
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
