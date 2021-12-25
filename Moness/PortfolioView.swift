//
//  PortfolioView.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import SwiftUI
import CoreData

struct PortfolioView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PortfolioCompany.symbol, ascending: true)],
        animation: .default)
    private var companies: FetchedResults<PortfolioCompany>
    @State private var showAddCompanySheet = false
    
    var body: some View {
        VStack {
            if companies.isEmpty {
                PortfolioPlaceholder()
            } else {
                List {
                    ForEach(companies) { company in
                        PortfolioRow(company: company)
                    }
                    .onDelete(perform: remove)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                #if os(iOS)
                EditButton()
                #endif
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showAddCompanySheet = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddCompanySheet) {
            SearchCompanyList()
        }
        .navigationTitle("Portfolio")
        .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
            NavigationView { content }
        }
    }
    
    // Remove company from portfolio
    private func remove(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
