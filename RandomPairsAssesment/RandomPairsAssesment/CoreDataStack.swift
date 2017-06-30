//
//  CoreDataStack.swift
//  RandomPairsAssesment
//
//  Created by ALIA M NEELY on 6/30/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack{
    
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RandomPairsAssesment")
        
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
