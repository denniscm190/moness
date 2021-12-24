//
//  SearchCompanyRow.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct SearchCompanyRow: View {
    var company: SearchCompanyResult
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(company.symbol)
                    .font(.headline)
                
                Text(company.securityName ?? "-")
                    .font(.callout)
                    .opacity(0.6)
                    .lineLimit(1)
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                Text(company.exchange ?? "-")
                    .font(.headline)
                
                Text(company.region ?? "-")
                    .font(.callout)
                    .opacity(0.6)
            }
        }
    }
}

struct SearchCompanyRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchCompanyRow(
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
