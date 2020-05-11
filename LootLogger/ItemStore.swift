//
//  ItemStore.swift
//  LootLogger
//
//  Created by partha on 5/10/20.
//  Copyright © 2020 partha. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItems(from fromIndex:Int, to toIndex:Int) {
        
        if(fromIndex == toIndex){
            return
        }
        
        let moveItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        allItems.insert(moveItem, at: toIndex)
    }
     
}
