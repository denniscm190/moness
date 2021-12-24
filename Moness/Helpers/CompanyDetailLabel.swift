//
//  CompanyDetailLabel.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct CompanyDetailLabel: View {
    var name: String
    var value: Text
    
    var body: some View {
        HStack {
            Text("\(name):")
                .font(.headline)
            
            value
                .lineLimit(1)
        }
    }
}

struct CompanyDetailLabel_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailLabel(name: "Symbol", value: Text("AAPL"))
    }
}
