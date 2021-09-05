//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Arun on 03/09/2021.
//

@testable import Recipes
import XCTest

class RecipesTestsFetchData: XCTestCase {
    var service: REServices?
    override func setUpWithError() throws {
        service = REServices()
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func testLoadingFromJSON() throws {
        service?.fetchRecipes { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Failed to read from JSON file")
            }
        }
    }
    
    func testLoadingIngredients() throws {
        service?.fetchRecipes { result in
            switch result {
            case .success(let ingredients):
                XCTAssertNotNil(ingredients)
            case .failure:
                XCTFail("Failed to read from JSON file")
            }
        }
    }
}
