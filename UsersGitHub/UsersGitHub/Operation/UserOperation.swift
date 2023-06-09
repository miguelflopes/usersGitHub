//
//  UserOperation.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

final class UserOperation<T: Decodable>: Operation {
    private let session: URLSession
    private let url: URL
    var result: T?
    var error: Error?
        
    init(session: URLSession, url: URL) {
        self.session = session
        self.url = url
    }
    
    override func main() {
        guard !isCancelled else { return }
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            defer { semaphore.signal() }
            guard let self = self, !self.isCancelled else { return }
            if let error = error {
                self.error = error
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                self.error = NetworkError.invalidResponse
                return
            }
            switch httpResponse.statusCode {
            case 200..<300:
                guard let data = data else {
                    self.error = NetworkError.invalidData
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    self.result = result
                } catch {
                    self.error = error
                }
            case 400..<500:
                self.error = NetworkError.badRequest
            case 500..<600:
                self.error = NetworkError.serverError
            default:
                self.error = NetworkError.unknownError
            }
        }
        task.resume()
        semaphore.wait()
    }
}
