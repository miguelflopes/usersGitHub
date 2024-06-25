//
//  UserManagerMock.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

import Foundation
@testable import UsersGitHub

final class UserManagerMock: UserManagerProtocol {
    var fetchUserResult: Result<[UsersModel]?, Error>!
    var searchUserResult: Result<SearchUserModel?, Error>!
    var fetchUserDetailsResult: Result<[UserDetailModel]?, Error>!
    
    private(set) var fetchUserCount = 0
    func fetchUser(completion: @escaping UsersCompletion) {
        fetchUserCount += 1
        completion(fetchUserResult)
    }
    
    private(set) var searchUserCount = 0
    func searchUser(search: String, completion: @escaping SearchUserCompletion) {
        searchUserCount += 1
        completion(searchUserResult)
    }
    
    private(set) var fetchUserDetailsCount = 0
    func fetchUserDetails(userName: String, completion: @escaping UserDetailsCompletion) {
        fetchUserDetailsCount += 1
        completion(fetchUserDetailsResult)
    }
}
