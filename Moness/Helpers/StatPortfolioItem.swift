//
//  StatPortfolioItem.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct StatPortfolioItem: View {
    var stat: StatsMethods.StatResult
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 150)
            .foregroundColor(stat.color)
            .opacity(0.1)
            .overlay(
                VStack(alignment: .leading, spacing: 15) {
                    Text("\(stat.methodName)".uppercased())
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("\(formatToCurrency(amount: stat.value, with: "USD"))")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    HStack {
                        if stat.pctValue >= 0 {
                            Image(systemName: stat.highSymbol)
                        } else {
                            Image(systemName: stat.lowSymbol)
                        }
                        
                        Text("\(formatToPercent(amount: stat.pctValue))")
                            .fontWeight(.bold)
                    }
                    .font(.headline)
                    .foregroundColor(stat.color)
                }
                    .padding()
                , alignment: .leading)
    }
}

struct StatPortfolioItem_Previews: PreviewProvider {
    static var previews: some View {
        StatPortfolioItem(
            stat:
                StatsMethods.StatResult(
                    methodName: "Market value",
                    color: .orange,
                    value: 43245.30,
                    pctValue: 0.03,
                    lowSymbol: "arrowtriangle.down.fill",
                    highSymbol: "arrowtriangle.up.fill"
                )
        )
    }
}
