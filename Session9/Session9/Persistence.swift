//
//  Persistence.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Session9")
        container.loadPersistentStores { _, error in
            if let er = error as NSError? {
                fatalError("Error al conectarse a la BD, \(er.localizedDescription)")
            }
        }
    }
}
