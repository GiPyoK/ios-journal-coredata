//
//  CoreDataStack.swift
//  JournalCoreData
//
//  Created by Gi Pyo Kim on 10/14/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    // Let us access the CoreDataStack from anywhere in the app.
    static let shared = CoreDataStack()
    
    // Set up a persistent container
    lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "JournalCoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // Create easy access to the moc (managed object context)
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveToPersistentStore() {
        do {
            try mainContext.save()
        } catch {
            NSLog("Error saving context: \(error)")
            mainContext.reset()
        }
    }
}
