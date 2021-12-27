//
//  Sidebar.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 27/12/21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: StatsView()) {
                Label("Stats", systemImage: "chart.bar.fill")
            }
            
            NavigationLink(destination: PortfolioView()) {
                Label("Portfolio", systemImage: "plus.circle.fill")
            }
            
            NavigationLink(destination: AboutView()) {
                Label("About", systemImage: "info.circle.fill")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Categories")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
