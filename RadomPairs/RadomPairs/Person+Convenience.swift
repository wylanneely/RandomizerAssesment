//
//  Person+Convenience.swift
//  RadomPairs
//
//  Created by ALIA M NEELY on 6/30/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    
   @discardableResult convenience init(name: String,
                     savedIndex: Int = 0,
                     context: NSManagedObjectContext = CoreDataStack.context){
        
        self.init(context: context)
        self.name = name
        self.savedIndex = Int16(savedIndex)
    }
}





