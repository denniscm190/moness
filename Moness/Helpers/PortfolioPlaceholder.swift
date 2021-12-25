//
//  PortfolioPlaceholder.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct PortfolioPlaceholder: View {
    var body: some View {
        VStack {
            Group {
                Image(systemName: "plus.circle.fill")
                    .padding(.bottom)
                
                Text("No companies")
                    .padding(.bottom, 5)
                    .multilineTextAlignment(.center)
            }
            .font(.system(size: 30))
            .foregroundColor(.secondary)
            
            Text("Search and add companies to the portfolio")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}

struct PortfolioPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioPlaceholder()
    }
}
