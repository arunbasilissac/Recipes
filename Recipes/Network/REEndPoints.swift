//
//  REEndPoints.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import Foundation

struct REEndPoint {
    let path: String
    var queryItems: [URLQueryItem]?
    var url: URL? {
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = Constants.baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    static func ingredients() -> REEndPoint {
        REEndPoint(
            path: "/v3/45a5a07f-e981-4918-9c31-090b121d6c5f"
        )
    }

    static func staticUrl(for string: String) -> URL? {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        return url
    }
    
}
