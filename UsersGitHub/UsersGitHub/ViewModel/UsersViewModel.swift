//
//  UsersViewModel.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol UsersViewModelDelegate {
    func onUsersFetchSuccess(_ users: [UsersModel])
    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String)
}

class UsersViewModel: UsersViewModelProtocol {
    
    // MARK: - Public Properties
    
    var delegate: UsersViewModelDelegate?
    
    // MARK: - Private Properties
    
    private let manager: UserManagerProtocol
    
    // MARK: - Initializer
    
    init(manager: UserManagerProtocol = UserManager()) {
        self.manager = manager
        
    }
    
    // MARK: - Public Methods
    
    /// Call manager to fetch users in api
    func fetchUsers() {
        manager.fetchUser { [weak self] result in
            sleep(3) // Simule loading
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.delegate?.onUsersFetchSuccess(users)
            case .failure(let error):
                self.handlerError(error)
            }
        }
    }
    
    
    /// Call manager to search the textField
    /// - Parameter search: TextField inputs
    func search(search: String) {
        manager.searchUser(search: search) { [weak self] result in
            sleep(3) // Simule loading
            guard let self = self else { return }
            switch result {
            case .success(let result):
                guard let searchUsers = result.users, !searchUsers.isEmpty else { self.handlerSearchError(); return }
                self.delegate?.onUsersFetchSuccess(searchUsers)
            case .failure(let error):
                self.handlerError(error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handlerSearchError() {
        self.delegate?.onUsersFetchError(StringHelper.errorTitleAlert, StringHelper.errorSearchMessageAlert)
    }
    
    private func handlerError(_ error: Error) {
        // Pode ser criado uma unica mensagem de error para o usuario, ou então de acordo com o tipo de erro abaixo.
        // Existe varias maneiras de capturar o erro e mostrar para o usuario de forma mais amigável.
        
        var mensageError: String
        guard let error = error as? NetworkError else { return }
        switch error {
        case .invalidURL:
            mensageError = StringHelper.errorAlert
        case .invalidResponse:
            mensageError = StringHelper.errorAlert
        case .invalidData:
            mensageError = StringHelper.errorAlert
        case .badRequest:
            mensageError = StringHelper.errorAlert
        case .serverError:
            mensageError = StringHelper.errorAlert
        case .unknownError:
            mensageError = StringHelper.errorAlert
        }
        self.delegate?.onUsersFetchError(StringHelper.errorTitleAlert, mensageError)
    }
}
