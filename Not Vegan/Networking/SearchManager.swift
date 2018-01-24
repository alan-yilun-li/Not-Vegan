//
//  SearchManager.swift
//  Not Vegan
//
//  Created by Alan Li on 2018-01-22.
//  Copyright © 2018 Alan Li. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let PARSER_ENDPOINT = "https://api.edamam.com/api/food-database/parser"
private let INFO_ENDPOINT = "https://api.edamam.com/api/food-database/nutrients"
private let KILOGRAM_MEASURE_URI = "http://www.edamam.com/ontologies/edamam.owl#Measure_kilogram"


class SearchManager {
    
    static let shared = SearchManager()
    
    private init() {}
    
    func search(for food: String) {
     
        var requestString = PARSER_ENDPOINT
        requestString += "?ingr=" + food.edamamStringEncode() + "&" // Adding food
        requestString += "app_id=" + APIKeys.APP_ID + "&"
        requestString += "app_key=" + APIKeys.APP_KEY
  
        Alamofire.request(requestString).responseJSON { response in
            guard response.error == nil else {
                print(response.error!)
                return
            }
            let json = JSON(response.result.value!)
            print(json)
            let parse = json["parsed"]
            if parse.isEmpty {
                // Handle null result
                return
            }
            print("PARSE COUNT: \(parse.count)")
            let uri = parse.first!.1["food"]["uri"].stringValue // Extracting the URI
            
            // Making request for vegan info
            var requestString = INFO_ENDPOINT
            requestString += "?app_id=" + APIKeys.APP_ID + "&"
            requestString += "app_key=" + APIKeys.APP_KEY
            
            let food: [String : Any] = ["quantity" : 1,
                                        "measure_URI" : KILOGRAM_MEASURE_URI,
                                        "food_URI" : uri]
            
            let params: [String : Any] = ["ingredients" : [food]]
            
            Alamofire.request(requestString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                guard response.error == nil else {
                    print(response.error!)
                    return
                }
                print(response)
                let json = JSON(response.result.value!)
                print(json)
            }
        }
    }
}
