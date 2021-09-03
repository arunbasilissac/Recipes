//
//  REIngredientsTableViewCell.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import UIKit

class REIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelIngredient: UILabel!
    var ingredient: String? {
        didSet {
            setData()
        }
    }
    
    private func setData() {
        guard let ingredient = self.ingredient else {
            return
        }
        labelIngredient.text = ingredient
    }
}
