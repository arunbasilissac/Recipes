//
//  Constants.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import Foundation

struct Constants {
    static let baseURL: String = "run.mocky.io"
}

struct Alert {
    static let okButtonLabel: String = "Ok"
    static let errorTitle: String = "Oops 🙁"
    static let noRecipes: String = "Sorry, no recipes available for the ingredients you have. Please gather some more ingredients"
}

struct ReuseIdentifier {
    static let recipeHeaderView: String = "recipeHeaderView"
    static let ingredientsTableViewCell: String = "REIngredientsTableViewCell"
}
