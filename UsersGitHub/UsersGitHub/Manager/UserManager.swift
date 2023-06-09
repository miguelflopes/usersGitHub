//
//  UserManager.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

final class UserManager: UserManagerProtocol {
    private let session: URLSession
    private let task = OperationQueue()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchUser(completion: @escaping (Result<[UsersModel], Error>) -> Void) {
        guard let url = URL(string: ApplicationConstants.PathAPI().users) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let operation = UserOperation<[UsersModel]>(session: session, url: url)
        operation.completionBlock = { [weak operation] in
            if let error = operation?.error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let user = operation?.result {
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
        task.addOperation(operation)
    }
    
    func searchUser(search: String, completion: @escaping (Result<SearchUserModel, Error>) -> Void) {
        guard let url = URL(string: ApplicationConstants.PathAPI().userSearch.appending(search)) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        task.cancelAllOperations()
        let operation = UserOperation<SearchUserModel>(session: session, url: url)
        operation.completionBlock = { [weak operation] in
            if let error = operation?.error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let user = operation?.result {
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
        task.addOperation(operation)
    }
    
    func fetchUserDetails(userName: String, completion: @escaping (Result<[UserDetailModel], Error>) -> Void) {
        let baseURL = ApplicationConstants.PathAPI().usersDetail.replaceStringToURL(occurrence: "*", with: userName)
        guard let url = baseURL else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        task.cancelAllOperations()
        let operation = UserOperation<[UserDetailModel]>(session: session, url: url)
        operation.completionBlock = { [weak operation] in
            if let error = operation?.error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let user = operation?.result {
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
        task.addOperation(operation)
    }
}
