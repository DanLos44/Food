//
//  HomeTableViewCell.swift
//  Food
//
//  Created by Daniel on 26/01/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func populate(with foodDB: FoodDB) {
        nameLabel.text = foodDB.name

        addressLabel.text = foodDB.address

        phoneLabel.text = foodDB.phone
    }
}
