//
//  Constants.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol PathAPIProtocol {
    var users: String { get }
    var usersDetail: String { get }
    var userSearch: String { get }
}

// MARK: - PathAPI

final class PathAPI: PathAPIProtocol {
    var users = "https://api.github.com/users"
    var usersDetail = "https://api.github.com/users/*/repos"
    var userSearch = "https://api.github.com/search/users?q="
}
