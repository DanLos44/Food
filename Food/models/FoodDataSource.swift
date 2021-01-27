//
//  FoodDataSource.swift
//  Food
//
//  Created by Daniel on 22/01/2021.
//

import Foundation

struct FoodRequest {
    let url:URL
    let apiKey = "AIzaSyBHs8w833vy7PhGWU6ECzgljQcgqBAsjC4"
    
    init(place:String, city:String) {
        
        let resourceString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(place)+in+\(city)&key=\(apiKey)"
        
        guard let url = URL(string: resourceString) else { fatalError()}
        
        self.url = url
    }
    
    func getFoods (completion: @escaping(Result<FoodResults, Errors>) -> Void ) {
        let dataTask = URLSession.shared.dataTask(with: url) {data, _,_ in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let foodResult = try decoder.decode(FoodResults.self, from: jsonData)
    
                completion(.success(foodResult))
            } catch {
                completion(.failure(.jsonDecodingError(cause: error)))
            }
        }
        dataTask.resume()
        
       
    }
    
    
}

struct FoodRequestWithPhone {
    let url:URL
    let apiKey = ""
    
    init(placeID:String) {
        
        let resourceString =  "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeID)&fields=formatted_phone_number&key=\(apiKey)"
        
        guard let url = URL(string: resourceString) else { fatalError()}
        
        self.url = url
    }
    
    func getFoods (completion: @escaping(Result<FoodResultsPhone, Errors>) ->Void ) {
        let dataTask = URLSession.shared.dataTask(with: url) {data, _,_ in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let foodResultPhone = try  decoder.decode(FoodResultsPhone.self, from: jsonData)

                completion(.success(foodResultPhone))
            } catch {

                completion(.failure(.jsonDecodingError(cause: error)))
            }
        }
        dataTask.resume()
    }
    
}


enum Errors:Error {
    case noData
    case jsonDecodingError(cause:Error)
}



