//
//  ContentView.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 18/12/21.
//

import SwiftUI

struct ContentView: View {
    private enum Tab {
        case stats, portfolio, about
    }
    
    @State private var tab: Tab = .stats
    
    @ViewBuilder var view: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationView {
                Sidebar()
                StatsView()
            }
        } else {
            TabView(selection: $tab) {
                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.fill")
                    }
                    .tag(Tab.stats)

                PortfolioView()
                    .tabItem {
                        Label("Portfolio", systemImage: "plus.circle.fill")
                    }
                    .tag(Tab.portfolio)
                
                AboutView()
                    .tabItem {
                        Label("About", systemImage: "info.circle.fill")
                    }
                    .tag(Tab.about)
            }
        }
    }
    
    var body: some View {
        view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
