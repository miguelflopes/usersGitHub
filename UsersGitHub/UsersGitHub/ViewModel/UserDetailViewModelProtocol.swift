//
//  UserDetailViewModelProtocol.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol UserDetailViewModelProtocol {
    
    // MARK: - Properties
    
//    var model: UsersResponseModel { get }
    var delegate: UserDetailViewModelDelegate? { get set }
    
    // MARK: - Methods
    
    func fetchUserDetails()
}
