//
//  StringParser.swift
//  Not Vegan
//
//  Created by Alan Li on 2018-01-22.
//  Copyright © 2018 Alan Li. All rights reserved.
//

import Foundation

extension String {
    
    func edamamStringEncode() -> String {
        var parts: [String] = self.components(separatedBy: .whitespacesAndNewlines)
        var returnString = ""
        for i in 0..<parts.count {
            returnString += parts[i]
            if (i != parts.count - 1) {
                returnString += "%20" // Required by edamam endpoint
            }
        }
        return returnString
    }
}
