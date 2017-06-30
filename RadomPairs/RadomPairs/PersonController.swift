//
//  PersonController.swift
//  RadomPairs
//
//  Created by ALIA M NEELY on 6/30/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static var shared = PersonController()
    
    var people: [Person] {
        return fetchPeople()
    }
    
    func fetchPeople() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        do { return try CoreDataStack.context.fetch(request) }
        catch { print("Error while fetching person from CoreData")
            return [] }
    }
    
    func createPerson(name: String){
        Person(name: name)
        saveToCoreData()
    }
    
    func updateIndexOfPerson(person: Person , index: Int){
        person.savedIndex = Int16(index)
        saveToCoreData()
    }
    
    func deletePerson(person: Person){
        CoreDataStack.context.delete(person)
        saveToCoreData()
    }
    
    func saveToCoreData() {
        let moc = CoreDataStack.context
        do { try moc.save() }
        catch { print("Error while Saving to CoreData")
            
        }
    }
    
}
