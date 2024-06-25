//
//  UserManager.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

final class UserManager: UserManagerProtocol {
    private let session: URLSession
    private let apiClient: PathAPIProtocol
    private let network: NetworkProtocol
    private let task = OperationQueue()

    init(network: NetworkProtocol = Network(),
         session: URLSession = .shared,
         apiClient: PathAPIProtocol = PathAPI())
    {
        self.network = network
        self.session = session
        self.apiClient = apiClient
    }

    func fetchUser(completion: @escaping UsersCompletion) {
        guard let url = URL(string: apiClient.users) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let operation = BlockOperation {
            self.network.execute(session: self.session, url: url, completion: completion)
        }
        task.addOperation(operation)
    }

    func searchUser(search: String, completion: @escaping SearchUserCompletion) {
        guard let url = URL(string: apiClient.userSearch.appending(search)) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        task.cancelAllOperations()
        let operation = BlockOperation {
            self.network.execute(session: self.session, url: url, completion: completion)
        }
        task.addOperation(operation)
    }

    func fetchUserDetails(userName: String, completion: @escaping UserDetailsCompletion) {
        let baseURL = apiClient.usersDetail.replaceStringToURL(occurrence: "*", with: userName)
        guard let url = baseURL else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        task.cancelAllOperations()
        let operation = BlockOperation {
            self.network.execute(session: self.session, url: url, completion: completion)
        }
        task.addOperation(operation)
    }
}
