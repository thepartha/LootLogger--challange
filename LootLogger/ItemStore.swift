//
//  ItemStore.swift
//  LootLogger
//
//  Created by partha on 5/10/20.
//  Copyright © 2020 partha. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [[Item](),[Item]()]
    var sections = ["Price > $50", "Price < $50"]
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        if newItem.valueInDollars >= 50 {
        allItems[0].append(newItem)
        } else {
            allItems[1].append(newItem)
        }
         
        return newItem
    }
    
    func removeItem(_ item: Item){
        let sectionIndex = item.valueInDollars >= 50 ? 0 : 1
        if let index = allItems[sectionIndex].firstIndex(of: item){
                    allItems[sectionIndex].remove(at: index)
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
