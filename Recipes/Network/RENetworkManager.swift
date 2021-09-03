//
//  RENetworkManager.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import UIKit

class RENetworkManager {
    
    static let sharedInstance: RENetworkManager = RENetworkManager()
    let cache: NSCache = NSCache<NSString, UIImage>()
    var decoder: JSONDecoder {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    init() {}
    
    // MARK: - URLSession Data task
    
    func fetchData <T: Decodable>(from url: URL, completion: @escaping (Result<T, REError>) -> Void) {

        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(( _, let data)):
                do {
                    let result: T = try self.decoder.decode(T.self, from: data)
                    
                    completion(.success(result))
                } catch {
                    if let error: REError = error as? REError {
                        return completion(.failure(error))
                    }
                    
                    completion(.failure(.invalidData))
                }
            case .failure(let exception):
                completion(.failure(exception))
            }
        }
        
        task.resume()
    }
    
    // MARK: - Fetch Data from file
    
    func fetchDataFrom <T: Decodable>(from filePath: URL, completion: @escaping (Result<T, REError>) -> Void) {
        do {
            let data = try Data(contentsOf: filePath)
            let result: T = try self.decoder.decode(T.self, from: data)
            completion(.success(result))
        } catch {
            if let error: REError = error as? REError {
                return completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch image from URL or from cache
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey: NSString = NSString(string: urlString)
        if let image: UIImage = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url: URL = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
}
