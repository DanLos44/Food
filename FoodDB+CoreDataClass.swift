//
//  FoodDB+CoreDataClass.swift
//  Food
//
//  Created by Daniel on 26/01/2021.
//
//

import Foundation
import CoreData

@objc(FoodDB)
public class FoodDB: NSManagedObject {

    
    convenience init(name:String, address:String, phone: String){
        self.init(context: Database.shared.context)
        
        self.name = name
        self.address = address
        self.phone = phone
    }
    
    
}
