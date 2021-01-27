//
//  FoodTableViewCell.swift
//  Food
//
//  Created by Daniel on 23/01/2021.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!

    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
}
