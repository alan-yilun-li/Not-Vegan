//
//  SearchManager.swift
//  Not Vegan
//
//  Created by Alan Li on 2018-01-22.
//  Copyright © 2018 Alan Li. All rights reserved.
//

import Foundation
import Alamofire

private let PARSER_ENDPOINT = "https://api.edamam.com/api/food-database/parser"

class SearchManager {
    
    static let shared = SearchManager()
    
    private init() {}
    
    func search(for food: String) {
     
        var requestString = PARSER_ENDPOINT
        requestString += "?ingr=" + food.edamamStringEncode() + "&" // Adding food
        requestString += "app_id=" + APIKeys.APP_ID + "&"
        requestString += "app_key=" + APIKeys.APP_KEY
        /*
        var params: Parameters = ["ingr" : food.edamamStringEncode(),
                                  "app_id" : APIKeys.APP_ID,
                                  "app_key" : APIKeys.APP_KEY,
                                  "page" : 0]
        */
        print("full request string is: \(requestString)")
        
        Alamofire.request(requestString).responseJSON { response in
            
            print("Response JSON: \(String(describing: response.result.value))")
        }
    }
}
