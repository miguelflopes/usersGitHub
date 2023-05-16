//
//  String.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

// MARK: - String

extension String {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    
    func convertStringToDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
    }
    
    func replaceStringToURL(occurrence: String, with replacingString: String) -> URL? {
        return URL(string: self.replacingOccurrences(of: occurrence, with: replacingString))
    }
}
