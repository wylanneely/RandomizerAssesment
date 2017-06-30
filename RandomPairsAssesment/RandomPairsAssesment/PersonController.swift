//
//  PersonController.swift
//  RandomPairsAssesment
//
//  Created by ALIA M NEELY on 6/30/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CoreData

struct PersonController {
    
    
    var people: [Person?] {
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
 
    
    mutating func randomizePeople(){
        
      let shuffledPeople = self.people.shuffled()
        
        let oldPeople = self.people
        
        for peep in shuffledPeople {
            guard let name = peep?.name else {print("error saving shuffled people"); return}
            createPerson(name: name)
        }
        for person in oldPeople {
            guard let person = person else {return }
            CoreDataStack.context.delete(person)
        }
        
        
    }
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
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
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
