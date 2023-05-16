//
//  UserManagerProtocol.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

// MARK: - UserManagerProtocol

public protocol UserManagerProtocol {
    
    // MARK: - Functions
    
    func fetchUser(completion: @escaping (Result<[UsersModel], Error>) -> Void)
    func searchUser(search: String, completion: @escaping (Result<SearchUserModel, Error>) -> Void)
    func fetchUserDetails(userName: String, completion: @escaping (Result<[UserDetailModel], Error>) -> Void)
}
