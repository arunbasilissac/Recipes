//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Arun on 03/09/2021.
//

@testable import Recipes
import XCTest

class RecipesTests: XCTestCase {

    func testLoadingFromJSON() throws {
        let service = REServices()
        service.fetchRecipes { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Failed to read from JSON file")
            }
        }
    }

}
