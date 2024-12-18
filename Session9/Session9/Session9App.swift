//
//  Session9App.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

@main
struct Session9App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
