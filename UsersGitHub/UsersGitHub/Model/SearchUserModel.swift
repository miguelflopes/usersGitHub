//
//  SearchUserModel.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

public struct SearchUserModel: Codable, Equatable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let users: [UsersModel]?

    public enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case users = "items"
    }
}
