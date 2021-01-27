//
//  FoodApi.swift
//  Food
//
//  Created by Daniel on 22/01/2021.
//

import Foundation

struct FoodResults:Codable {
    let results:[FoodDetail]
}

//the phone is located in another url request and not the same as above
struct FoodResultsPhone:Codable {
    let result:FoodDetailWithPhone
}

struct FoodDetail:Codable {
    let name:String?
    let formatted_address:String?
    let rating:Double?
    let price_level:Int?
    let place_id:String?
    let photos:[Photos]?
    
}

struct FoodDetailWithPhone:Codable {
    let formatted_phone_number:String
}

struct Photos:Codable {
    let height:Double?
    let width:Int?
    let photo_reference:String?
    

}



