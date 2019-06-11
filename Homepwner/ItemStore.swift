//
//  ItemStore.swift
//  Homepwner
//
//  Created by Jakub Kozlowicz on 03.06.19.
//  Copyright © 2019 Jakub Kozlowicz. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    
    init() {
        
        if let data = try? Data(contentsOf: itemArchiveURL) {
  
            do {
                if let archivedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item]{
                    allItems = archivedItems
                }
                
                
            } catch let error {
                print("No items have been archive or error while loading the items archive!")
                print("The following error occured: \(error.localizedDescription)")
            }
            
        }

    }
    
    @discardableResult func saveItems() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
        } catch let error {
            print("Unable to save items!")
            print("The following error occured: \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            if index == allItems.count - 1 {
                return
            }
            allItems.remove(at: index)
        }
    }
}
