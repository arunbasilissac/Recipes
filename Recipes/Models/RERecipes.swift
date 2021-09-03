//
//  RERecipes.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import Foundation

class RERecipes: Decodable {
    var name: String
    var ingredients: [String]
    var isExpanded = false
    
    enum CodingKeys: String, CodingKey {
            case name, ingredients
        }
}
