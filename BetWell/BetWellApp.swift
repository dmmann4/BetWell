//
//  BetWellApp.swift
//  BetWell
//
//  Created by David Mann on 1/15/23.
//

import SwiftUI

@main
struct BetWellApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
