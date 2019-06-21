//
//  ItemListTableViewController.swift
//  Assessment_2
//
//  Created by Nic Gibson on 6/21/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit
import CoreData

class ItemListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let popUp = UIAlertController(title: "Add item to shopping list", message: nil, preferredStyle: .alert)
        popUp.addTextField { (textField) in textField.placeholder = "What is the item?" }
        //            popUp.addAction(UIAlertAction(title: "Add", style: .default, handler: nil))
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        let addItemAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let itemText = popUp.textFields?.first?.text else {return}
            ItemController.sharedInstance.createItemWith(name: itemText)
            // ItemController.sharedInstance.saveToPersistentStore()
        }
        popUp.addAction(addItemAction)
        popUp.addAction(dismissAction)
        present(popUp, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedInstance.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ButtonTableViewCell,
        let item = ItemController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row] else {return UITableViewCell()}
        cell.update(withItem: item)
        cell.delegate = self
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
 

}
