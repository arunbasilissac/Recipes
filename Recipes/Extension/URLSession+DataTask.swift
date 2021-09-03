//
//  URLSession+DataTask.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import Foundation

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), REError>) -> Void) -> URLSessionDataTask {
        dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(.unableToComplete))
                return
            }
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                result(.failure(.invalidData))
                return
            }

            if response.statusCode == 304 {
                result(.failure(.limitExceeded))
                return
            } else if response.statusCode != 200 {
                result(.failure(.invalidResponse))
                return
            }

            result(.success((response, data)))
        }
    }
}
