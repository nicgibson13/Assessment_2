//
//  ItemController.swift
//  Assessment_2
//
//  Created by Nic Gibson on 6/21/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    let fetchedResultsController: NSFetchedResultsController<Item>
    
    init() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false)]
        let resultsController: NSFetchedResultsController<Item> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch! \(error.localizedDescription)")
        }
    }
    
    //Singleton
    static let sharedInstance = ItemController()
    
    //Source of truth
    var items: [Item] = []
    
    //MARK: CRUD Functions
    func createItemWith(name: String) -> Item{
        let newItem = Item(name: name)
        saveToPersistentStore()
        return newItem
    }
    
    func updateItemWith(item: Item, name: String) {
        item.name = name
        saveToPersistentStore()
    }
    
    func deleteItem(item: Item) {
        item.managedObjectContext?.delete(item)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Error saving")
        }
        
        func toggleIsCollectedFor(item: Item) {
            item.isCollected = !item.isCollected
            saveToPersistentStore()
        }
    }
}
