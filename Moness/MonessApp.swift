//
//  MonessApp.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 18/12/21.
//

import SwiftUI

@main
struct MonessApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
