//
//  PersonController.swift
//  RandomPairsAssesment
//
//  Created by ALIA M NEELY on 6/30/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static var shared = PersonController()
    
    var people: [Person] {
        get{
        return fetchPeople()
        } set {
            
        }
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
    
    //    func updateIndexOfPerson(person: Person , index: Int){
    //        person.savedIndex = Int16(index)
    //        saveToCoreData()
    //    }
    
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
    
    func getRandomIndex(numberThreathold: Int) -> Int {
        return Int(arc4random_uniform(UInt32(numberThreathold - 1)))
    }
    
    func randomizePeople(){
        
       self.people = people.shuffled()
        
    }
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
