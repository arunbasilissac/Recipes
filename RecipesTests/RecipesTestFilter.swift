//
//  RecipiesTestFilter.swift
//  RecipesTests
//
//  Created by Arun on 05/09/21.
//

import XCTest
@testable import Recipes

class RecipesTestFilter: XCTestCase {
    
    var allRecipes: [RERecipes]!

    override func setUpWithError() throws {
        try importFromJson()
    }

    override func tearDownWithError() throws {
        allRecipes = nil
    }

    func importFromJson() throws {
        let service = REServices()
        service.fetchRecipes { result in
            switch result {
            case .success(let data):
                self.allRecipes = data
                XCTAssertTrue(self.allRecipes.count == 6) // Test will not execute if it fails
            case .failure:
                XCTFail("Failed to read from JSON file")
            }
        }
    }
    
    func testForThreeRecipes() throws {
        let viewModel = RERecipesViewModel()
        let ingredients: Set<String> = ["Meat", "egg", "onion", "parmesan", "butter", "sugar", "chicken"]
        let recipes = viewModel.filter(recipesList: allRecipes, with: ingredients)
        XCTAssertTrue(recipes.count == 3)
    }
    
    func testForNoIngredients() throws {
        let viewModel = RERecipesViewModel()
        let ingredients: Set<String> = []
        let recipes = viewModel.filter(recipesList: allRecipes, with: ingredients)
        XCTAssertTrue(recipes.isEmpty)
    }
    
    func testForTomatoPasta() throws {
        let viewModel = RERecipesViewModel()
        let ingredients: Set<String> = ["tomato", "pasta", "water"]
        let recipes = viewModel.filter(recipesList: allRecipes, with: ingredients)
        XCTAssertTrue(recipes.count == 1)
        XCTAssertTrue(recipes.first?.name == "Tomato pasta")
    }
    
    func testForNoRecipes() throws {
        let viewModel = RERecipesViewModel()
        let ingredients: Set<String> = ["carrot", "orange", "water"]
        let recipes = viewModel.filter(recipesList: allRecipes, with: ingredients)
        XCTAssertTrue(recipes.isEmpty)
    }
    
    func testForAllIngredients() throws {
        let viewModel = RERecipesViewModel()
        let ingredients: Set<String> = ["tomato", "pasta", "water",
                                        "chicken", "butter", "onion",
                                        "biscuit", "sugar", "chocolate",
                                        "parmesan", "Meat", "egg"]
        let recipes = viewModel.filter(recipesList: allRecipes, with: ingredients)
        XCTAssertTrue(recipes.count == 6)
    }
    
    func testForIngredientsMultipleEntry() throws {
        let viewModel = RERecipesViewModel()
        let ingredients: Set<String> = ["tomato", "pasta", "water", "water", "pasta"]
        let recipes = viewModel.filter(recipesList: allRecipes, with: ingredients)
        XCTAssertTrue(recipes.count == 1)
        XCTAssertTrue(recipes.first?.name == "Tomato pasta")
    }

}
