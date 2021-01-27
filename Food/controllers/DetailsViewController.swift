//
//  DetailsViewController.swift
//  Food
//
//  Created by Daniel on 24/01/2021.
//

import UIKit
import SDWebImage
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    var foodDB: FoodDB?
    
    weak var delegate:DetailsViewControllerDelegate?
    
    @IBAction func call(_ sender: Any) {
        
        if let number = URL(string: "\(phone)") {
            UIApplication.shared.canOpenURL(number)
            
        }

        }
    
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Place", message:"Are you sure you want to save this place?", preferredStyle: .alert)
        
        let submitButton = UIAlertAction(title: "Add", style: .default) {(action) in
            
            let name = self.name.text
            let address = self.address.text
            let phone = self.phone.text
            
            if self.foodDB == nil{
               
                let foodDB = FoodDB(name: name ?? "", address: address ?? "", phone: phone ?? "")
                
                Database.shared.save(foodDB: foodDB)
                
                self.delegate?.addFoodDB(foodDB)
                
            }else if let fooddb = self.foodDB{
     
                fooddb.name = self.name.text
                fooddb.address = self.address.text
                fooddb.phone = self.phone.text
                
                Database.shared.save(foodDB: fooddb)
                
            }
        }
         
        
        alert.addAction(submitButton)
        self.present(alert,animated: true, completion: nil)
    }
    
    var food:FoodDetail?
    //this is used to get info to main thread from background
    var food2:String = "" {
        didSet {
            DispatchQueue.main.async {
                self.phone.text = self.food2
            }

            }
        }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURLString =          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=\(food?.photos?[0].width ?? 0 )&photoreference=\(food?.photos?[0].photo_reference ?? "")&key=AIzaSyBHs8w833vy7PhGWU6ECzgljQcgqBAsjC4"
            
        
        let url = URL(string: imageURLString )
        
        
        name.text = food?.name
        address.text = food?.formatted_address
        price.text = "Price: \(food?.price_level ?? 0)/4"
        rating.text = "Rating: \(food?.rating ?? 0.0)/5"
        poster.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "icons8-search"), options: .handleCookies, context: nil)
        
        getPhone(placeID: food?.place_id ?? "")
        
    }
    

    func getPhone(placeID:String){
        
        let foodRequestPhone = FoodRequestWithPhone(placeID: placeID)
    
        foodRequestPhone.getFoods { [weak self] result in
            switch result{
            case .failure(let err):
                print(err)
            case .success(let foods):
                
                //need to find a better solution but this works, get empty phone
                let s = String(describing: foods.result)
                let newString = s.replacingOccurrences(of: "FoodDetailWithPhone(formatted_phone_number: ", with: "")
                let newString2 = newString.replacingOccurrences(of: ")", with: "")
                
                    self?.food2 = "\(newString2)"

        }

    }

        
    }
    
}

protocol DetailsViewControllerDelegate: class {
    func addFoodDB(_ foodDB: FoodDB)
}
