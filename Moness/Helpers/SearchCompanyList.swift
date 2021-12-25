//
//  SearchCompanyList.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI

struct SearchCompanyList: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchSymbol = ""
    @State private var companies = [SearchCompanyResult]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(companies, id: \.self) { company in
                    NavigationLink(destination: AddCompany(company: company)) {
                        SearchCompanyRow(company: company)
                    }
                }
            }
            .onChange(of: searchSymbol) { _ in getSearch()}
            .searchable(text: $searchSymbol)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "multiply")
                    }
                }
            }
            .navigationTitle("Search a company")
        }
    }
    
    // Get searched companies
    private func getSearch() {
        let url = "https://api.simoleon.app/search/\(searchSymbol)"
        httpRequest(url: url, model: SearchCompanyResponse.self) { response in
            companies = response.message
        }
    }
}

struct SearchCompanyList_Previews: PreviewProvider {
    static var previews: some View {
        SearchCompanyList()
    }
}
