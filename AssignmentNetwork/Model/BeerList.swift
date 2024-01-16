//
//  BeerList.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/16/24.
//

import Foundation

struct BeerList: Codable {
    let name: String
    let abv: Double
    let description: String
    let image_url: String
    
    var abvString: String {
        "ABV : \(String(describing: abv))"
    }
}
