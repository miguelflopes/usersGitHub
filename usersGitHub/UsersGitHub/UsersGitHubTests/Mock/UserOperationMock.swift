//
//  UserOperationMock.swift
//  UsersGitHubTests
//
//  Created by hitss on 24/06/24.
//

import Foundation
@testable import UsersGitHub

final class UserOperationMock: NetworkProtocol {
    var successMock: Any?
    var failureMock: Error?

    func execute<T: Decodable>(session: URLSession, url: URL, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable {
        if let failureMock {
            completion(.failure(failureMock))
            return
        }

        if let successMock {
            completion(.success(successMock as? T))
            return
        } else {
            completion(.success(nil))
        }
    }
}
