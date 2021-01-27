//
//  HomeTableViewController.swift
//  Food
//
//  Created by Daniel on 26/01/2021.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var citySearch: UISearchBar!
        
    var items:[FoodDB] {
        return Database.shared.getFoodDB()
    }


    
    public static var cityName:String = "Tel+Aviv"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        citySearch.delegate = self
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? HomeTableViewCell{
            let foodDB = items[indexPath.row]
            cell.populate(with: foodDB)
        }
 
        return cell
    }
    

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
            
            let foodDB = self.items[indexPath.row]
            Database.shared.delete(foodDB: foodDB)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

    

}

extension HomeTableViewController : UISearchBarDelegate {
    
        func searchBarSearchButtonClicked(_ citySearch: UISearchBar) {
            
            print("entered here")
            var newString = citySearch.text
            
            guard let searchBarText = citySearch.text else {return}
            if(searchBarText.contains(" ")) {
                newString = searchBarText.replacingOccurrences(of: " ", with: "_")
            }
            HomeTableViewController.cityName = newString ?? "Tel+Aviv"
            
            print(HomeTableViewController.cityName, "is the city")
        }
        

    }

extension HomeTableViewController: DetailsViewControllerDelegate{
    
    func addFoodDB(_ foodDB: FoodDB) {
        //1) add the person to the array:
        guard let index = items.firstIndex(of: foodDB) else {return}
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}


