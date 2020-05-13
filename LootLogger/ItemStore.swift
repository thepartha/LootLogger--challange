//
//  ItemStore.swift
//  LootLogger
//
//  Created by partha on 5/10/20.
//  Copyright © 2020 partha. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [[Item(random: true)],[Item(random: true)]]
    var noItem: Bool = false
    
    
    @discardableResult func createItem(random: Bool,sectionIndex: IndexPath? = nil) -> Item{
        let newItem = Item(random: random)
        if let index = sectionIndex {
            allItems[index.section].append(newItem)
            noItem = true
        } else {
            if newItem.valueInDollars >= 50 {
            allItems[0].append(newItem)
            } else {
                allItems[1].append(newItem)
            }
            
        }
         
        return newItem
    }
    
    func removeItem(_ item: Item, _ sectionIndex: IndexPath){
        
        if let index = allItems[sectionIndex.section].firstIndex(of: item){
            allItems[sectionIndex.section].remove(at: index)
          }
    }
    
    func moveItems(from fromIndex:Int, to toIndex:Int, fromSection fromSectionIndex:Int, toSection toSectionIndex:Int) {
        if(fromSectionIndex == toSectionIndex) && (fromIndex == toIndex){
            return
        }
        let moveItem = allItems[fromSectionIndex][fromIndex]
        allItems[fromSectionIndex].remove(at: fromIndex)
        allItems[toSectionIndex].insert(moveItem, at: toIndex)
    }

}
