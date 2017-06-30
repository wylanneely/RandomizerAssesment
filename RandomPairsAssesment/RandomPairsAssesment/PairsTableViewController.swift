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
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
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
            PersonController.shared.createPerson(name: text)
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (PersonController.shared.people.count / 2)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PersonController.shared.people[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
}
