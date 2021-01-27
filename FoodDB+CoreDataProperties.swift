//
//  FoodDB+CoreDataProperties.swift
//  Food
//
//  Created by Daniel on 26/01/2021.
//
//

import Foundation
import CoreData


extension FoodDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodDB> {
        return NSFetchRequest<FoodDB>(entityName: "FoodDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?

}

extension FoodDB : Identifiable {

}
