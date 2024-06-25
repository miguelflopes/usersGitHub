//
//  Network.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol NetworkProtocol {
    func execute<T: Decodable>(session: URLSession,
                    url: URL,
                    completion: @escaping (Result<T?, Error>) -> Void)
}

final class Network: Operation, NetworkProtocol {
    override init() {}

    func execute<T: Decodable>(session: URLSession,
                    url: URL,
                    completion: @escaping (Result<T?, Error>) -> Void) {
        guard !isCancelled else { return }
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            defer { semaphore.signal() }
            guard let self = self, !self.isCancelled else { return }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidResponse))
                }
                return
            }
            switch httpResponse.statusCode {
            case 200..<300:
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.invalidData))
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case 400..<500:
                completion(.failure(NetworkError.badRequest))
            case 500..<600:
                completion(.failure(NetworkError.serverError))
            default:
                completion(.failure(NetworkError.unknownError))
            }
        }
        task.resume()
        semaphore.wait()
    }
}
