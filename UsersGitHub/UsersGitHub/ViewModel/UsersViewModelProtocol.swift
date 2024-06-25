//
//  UsersViewModelProtocol.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol UsersViewModelProtocol {
    
    // MARK: - Properties
    
    var delegate: UsersViewModelDelegate? { get set }
    
    // MARK: - Methods
    
    func fetchUsers()
    func search(search: String)
}
