//
//  StatsPlaceholder.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct StatsPlaceholder: View {
    var body: some View {
        VStack {
            Group {
                Image(systemName: "plus.circle.fill")
                    .padding(.bottom)
                
                Text("No stats available")
                    .padding(.bottom, 5)
                    .multilineTextAlignment(.center)
            }
            .font(.system(size: 30))
            .foregroundColor(.secondary)
            
            Text("Stats will appear here once a company is added to the portfolio")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}

struct StatsPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        StatsPlaceholder()
    }
}
