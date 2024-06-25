//
//  UserManagerProtocol.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

// MARK: - UserManagerProtocol

public protocol UserManagerProtocol {
    typealias UsersCompletion = (Result<[UsersModel]?, Error>) -> Void
    typealias SearchUserCompletion = (Result<SearchUserModel?, Error>) -> Void
    typealias UserDetailsCompletion = (Result<[UserDetailModel]?, Error>) -> Void

    // MARK: - Functions
    
    func fetchUser(completion: @escaping UsersCompletion)
    func searchUser(search: String, completion: @escaping SearchUserCompletion)
    func fetchUserDetails(userName: String, completion: @escaping UserDetailsCompletion)
}
