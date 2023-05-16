//
//  UserManagerMock.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

import Foundation
@testable import UsersGitHub

class UserManagerMock: UserManagerProtocol {
    var fetchUserResult: Result<[UsersModel], Error>!
    var searchUserResult: Result<SearchUserModel, Error>!
    var fetchUserDetailsResult: Result<[UserDetailModel], Error>!
    
    func fetchUser(completion: @escaping (Result<[UsersModel], Error>) -> Void) {
        completion(fetchUserResult)
    }
    
    func searchUser(search: String, completion: @escaping (Result<SearchUserModel, Error>) -> Void) {
        completion(searchUserResult)
    }
    
    func fetchUserDetails(userName: String, completion: @escaping (Result<[UserDetailModel], Error>) -> Void) {
        completion(fetchUserDetailsResult)
    }
}
