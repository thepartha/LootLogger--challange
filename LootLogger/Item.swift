//
//  Item.swift
//  LootLogger
//
//  Created by partha on 5/10/20.
//  Copyright © 2020 partha. All rights reserved.
//

import UIKit

class Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name &&
            lhs.valueInDollars == rhs.valueInDollars &&
            lhs.dateCreated == rhs.dateCreated &&
            lhs.serialNumber == rhs.serialNumber
        
    }
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    var section: String
    
    init(name:String, valueInDollars:Int, serialNumber: String?, section: String) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.section = section
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0..<100)
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "_").first!
            
            let section = randomValue >= 50 ? "> 50"  : "< 50"
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber, section: section)
        } else {
            self.init(name: "No Items found",  valueInDollars: 0, serialNumber: nil, section: "No Item found")
        }
    }
    
    
}
