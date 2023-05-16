//
//  NetworkError.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case badRequest
    case serverError
    case unknownError
}
