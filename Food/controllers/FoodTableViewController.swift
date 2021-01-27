//
//  FoodTableViewController.swift
//  Food
//
//  Created by Daniel on 22/01/2021.
//

import UIKit
import SDWebImage

class FoodTableViewController: UITableViewController {
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodList2:String = ""
    
    //gives us the number of results
    var foodList = [FoodDetail](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.foodList.count) places found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        createDefault()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return foodList.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodTableViewCell
        
        let food = foodList[indexPath.row]

        let imageURLString =          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(food.photos?[0].width ?? 0 )&photoreference=\(food.photos?[0].photo_reference ?? "")&key=AIzaSyBHs8w833vy7PhGWU6ECzgljQcgqBAsjC4"
            
        
        let url = URL(string: imageURLString )

                  
        cell.title?.text = food.name
        cell.address?.text = food.formatted_address
        cell.rating.text = "Rating: \(food.rating ?? 0.0)/5"
        cell.price.text = "Price: \(food.price_level ?? 0)/4 "

        cell.poster.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "icons8-search"), options: .handleCookies, context: nil)
                
        return cell
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailsViewController {
            dest.food = foodList[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    //load something @ start
    func createDefault() {
        
        let foodRequest = FoodRequest(place: "restaurants", city: HomeTableViewController.cityName)
        foodRequest.getFoods {[weak self] result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let foods):
                self?.foodList = foods.results
                
               
            }
        }
    }
    
}
        
    
    
extension FoodTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var newString = searchBar.text
        
        //remove space or else app crashes
        guard let searchBarText = searchBar.text else {return}
        if(searchBarText.contains(" ")) {
            newString = searchBarText.replacingOccurrences(of: " ", with: "+")
        }
        print("place name is:", newString)
        print("city name is", HomeTableViewController.cityName)

        let foodRequest = FoodRequest(place: newString ?? "Restaurant", city: HomeTableViewController.cityName)
        foodRequest.getFoods {[weak self] result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let foods):
                self?.foodList = foods.results

            
            }
        }
    }
}

