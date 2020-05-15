//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by partha on 5/10/20.
//  Copyright © 2020 partha. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    //injection through a property to give it a store.
    var itemStore: ItemStore!
    var filtersArray: [Item]!
    var filter:Bool = false
    
    @IBAction func addNewItem(_ sender:UIButton) {
        let newItem = itemStore.createItem(random: true)
        let sectionIndex = newItem.valueInDollars >= 50 ? 0 : 1
            if let index = itemStore.allItems[sectionIndex].firstIndex(of: newItem){
                 let indexPath = IndexPath(row: index, section: sectionIndex)
                tableView.insertRows(at: [indexPath], with: .automatic)
        }
        if itemStore.noItem == true {
            
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            if (itemStore.allItems[0].count == 0) && (itemStore.allItems[1].count == 0) {
                return
            } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
            }
        }
    }
    
    @IBAction func filterNames () {
        filter = !filter
        if filter {
            let allNames = self.itemStore.allItems[0] + self.itemStore.allItems[1]
            self.filtersArray = allNames.filter { (item) -> Bool in
                return item.isFavorite == true
            }
        }
        tableView.reloadData()
    }
    
    
    func createNoItems(sectionIndex: IndexPath) {
        let noItem = itemStore.createItem(random: false,sectionIndex: sectionIndex)
        if let index = itemStore.allItems[sectionIndex.section].firstIndex(of: noItem) {
            let indexPath = IndexPath(row: index, section: sectionIndex.section)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if !filter {
            return itemStore.allItems.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeader = ""
        if !filter {
            sectionHeader = itemStore.allItems[section][0].section
        } else {
            sectionHeader = "Favorites"
        }
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        let count: Int
        if !filter {
           count =  itemStore.allItems[section].count
        } else {
            count = filtersArray.count
        }
        return count
    }
    

    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let farry = filtersArray {
            print(farry.count)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item: Item
        if !filter {
        item = itemStore.allItems[indexPath.section][indexPath.row]
         } else {
         item = filtersArray[indexPath.row]
        }
        cell.textLabel?.text = item.isFavorite ? item.name + " Fav" : item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.section][indexPath.row]
            itemStore.removeItem(item,indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if itemStore.allItems[indexPath.section].count == 0 {
                createNoItems(sectionIndex: indexPath)
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       itemStore.moveItems(from: sourceIndexPath.row, to: destinationIndexPath.row, fromSection: sourceIndexPath.section, toSection: destinationIndexPath.section)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "Favorite", handler: { _,_,_ in
            self.itemStore.allItems[indexPath.section][indexPath.row].isFavorite = !self.itemStore.allItems[indexPath.section][indexPath.row].isFavorite
            tableView.cellForRow(at: indexPath)?.textLabel?.text =  self.itemStore.allItems[indexPath.section][indexPath.row].isFavorite ? self.itemStore.allItems[indexPath.section][indexPath.row].name + " Fav" : self.itemStore.allItems[indexPath.section][indexPath.row].name
        })
        let swipeConfig = UISwipeActionsConfiguration(actions: [favAction])
        swipeConfig.performsFirstActionWithFullSwipe = true
        return swipeConfig
    }
    
  
    
}
