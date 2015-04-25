//
//  Textbook.swift
//  TextbookApp
//
//  Created by Daniel Galvez on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import Foundation
import Parse

class Textbook: PFObject, PFSubclassing {
    
    @NSManaged var edition : Int
    @NSManaged var condition: String
    @NSManaged var price: Double
    @NSManaged var notes: String
    @NSManaged var name: String
    @NSManaged var owner: PFUser
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken, { () -> Void in
            self.registerSubclass()
        })
    }
    
    class func parseClassName() -> String {
        return "Textbook"
    }
    /*
    convenience init(edition:Int, condition: String, price: Double, notes: String, name: String) {
    init()
    self.edition = edition
    self.condition = condition
    self.price = price
    self.notes = notes
    self.name = name
    }*/
}
