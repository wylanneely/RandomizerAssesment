 //
//  PairsTableViewController.swift
//  RandomPairsAssesment
//
//  Created by ALIA M NEELY on 6/30/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var personController = PersonController()
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        personController.randomizePeople()
        personController.saveToCoreData()
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        //Create and present the add person alert
        var alertTextField: UITextField?
        let alertController = UIAlertController(title: "Add Person", message: "Add a person to the list!", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            alertTextField = textField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField?.text, !text.isEmpty else { return }
            self.personController.createPerson(name: text)
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if personController.people.count % 2 == 0 {
            return personController.people.count / 2
        }
        return personController.people.count / 2 + 1
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        let newIndex = sectionAndRowtoInt(section: section, row: row )
        if newIndex >= personController.people.count {
            return cell
        }
        guard let person = personController.people[newIndex] else {return cell}
        cell.textLabel?.text = person.name
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let person = personController.people[indexPath.row] else {return}
            personController.deletePerson(person: person)
            tableView.reloadData()
    }
}
    //Help Display People in proper sections and rows
    
    func sectionAndRowtoInt(section: Int, row: Int) -> Int {
        return (section * 2) + row
    }
    
    
}
