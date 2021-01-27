//
//  Database.swift
//  Food
//
//  Created by Daniel on 26/01/2021.
//

import CoreData

class Database {
    
    lazy var persistentContainer:
        NSPersistentContainer = {
            
            let container = NSPersistentContainer(name:"Database")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Out of disk space")
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    private init(){}
    static let shared = Database()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(foodDB: FoodDB){
        context.delete(foodDB)
        saveContext()
    }
    
    
    func save(foodDB: FoodDB){

        saveContext()
    }
    
    func getFoodDB()-> [FoodDB]{
        
        let request: NSFetchRequest<FoodDB> = FoodDB.fetchRequest()
        
        
        if let foodDB = try? context.fetch(request){
            return foodDB
        }
        
        return  []
    }
}
