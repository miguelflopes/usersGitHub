//
//  NSObject.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

// MARK: - NSObject

extension NSObject {
    
    /// String describing the class name.
    public class var className: String {
        return String(describing: self)
    }
}
