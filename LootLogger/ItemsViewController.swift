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
    
    @IBAction func addNewItem(_ sender:UIButton) {
        
        let newItem = itemStore.createItem()
        let sectionIndex = newItem.valueInDollars >= 50 ? 0 : 1
            if let index = itemStore.allItems[sectionIndex].firstIndex(of: newItem){
                 let indexPath = IndexPath(row: index, section: sectionIndex)
                tableView.insertRows(at: [indexPath], with: .automatic)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeader = ""
        if (itemStore.allItems[0].count == 0) && (itemStore.allItems[1].count == 0) {
            sectionHeader = "There are no items"
            return sectionHeader
        } else {
        if section == 0 {
            sectionHeader = itemStore.sections[0]
        } else {
            sectionHeader = itemStore.sections[1]
        }
        return sectionHeader
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        if itemStore.allItems[section].count == 0 {
            return 1
        } else {
        return itemStore.allItems[section].count + 1
        }
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let noItemCell = tableView.dequeueReusableCell(withIdentifier: "NoItemCell")!

        if (itemStore.allItems[0].count == 0) && (itemStore.allItems[1].count == 0) {
            noItemCell.textLabel?.text = "No Items Found"
             return noItemCell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let item = itemStore.allItems[indexPath.section][indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
             return cell
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
//        if (itemStore.allItems[0].count == 0) && (itemStore.allItems[1].count == 0) {
//            cell.textLabel?.text = "No Items Found"
//        } else {
//            let item = itemStore.allItems[indexPath.section][indexPath.row]
//            cell.textLabel?.text = item.name
//            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
//        }
//        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.section][indexPath.row]
            itemStore.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        return
       // itemStore.moveItems(from: sourceIndexPath.row, to: destinationIndexPath.row, fromSection: sourceIndexPath.section, toSection: destinationIndexPath.section)
    }
    
    
}
