//
//  REError.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import Foundation

enum REError: Error {

    case unableToComplete
    case invalidResponse
    case invalidData
    case limitExceeded
    case invalidURL
    case invalidInputString
    case noSolution

    var description: String {
            switch self {
            case .unableToComplete:
                return "Unable to complete your request. Please check your internet connection"
            case .invalidResponse:
                return "Invalid response from the server. Please try again."
            case .invalidData:
                return "The data received from the server was invalid. Please try again."
            case .limitExceeded:
                return "API rate limit exceeded. Try again later."
            case .invalidURL:
                return "The url attached is invalid."
            case .invalidInputString:
                return "The input string received from the server was invalid."
            case .noSolution:
                return "​No solution exists"
            }
        }
}
