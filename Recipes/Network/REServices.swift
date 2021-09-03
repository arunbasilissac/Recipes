//
//  REServices.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import Foundation

class REServices {
    
    func fetchIngredients(completion: @escaping (Result<Set<String>, REError>) -> Void) {
        guard let url = REEndPoint.ingredients().url else {
            completion(.failure(.invalidURL))
            return
        }
        RENetworkManager.sharedInstance.fetchData(from: url) { (result: Swift.Result<Set<String>, REError>) in
            switch result {
            case .success(let dataArray):
                completion(.success(dataArray))
            case .failure(let exception):
                completion(.failure(exception))
            }
        }
    }
    
    func fetchRecipes(completion: @escaping (Result<[RERecipes], REError>) -> Void) {
        guard let url = Bundle.main.url(forResource: "Recipes", withExtension: "json") else {
            completion(.failure(.invalidURL))
            return
        }
        RENetworkManager.sharedInstance.fetchDataFrom(from: url) { (result: Swift.Result<[RERecipes], REError>) in
            switch result {
            case .success(let dataArray):
                completion(.success(dataArray))
            case .failure(let exception):
                completion(.failure(exception))
            }
        }
    }
}
