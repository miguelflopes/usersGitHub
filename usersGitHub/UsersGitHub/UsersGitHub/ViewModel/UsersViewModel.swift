//
//  UsersViewModel.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol UsersViewModelDelegate: AnyObject {
    func onUsersFetchSuccess(_ users: [UsersModel]?)
    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String)
    func loading(isLoading _: Bool)
}

final class UsersViewModel: UsersViewModelProtocol {
    
    // MARK: - Public Properties
    
    weak var delegate: UsersViewModelDelegate?

    // MARK: - Private Properties
    
    private let manager: UserManagerProtocol
    
    // MARK: - Initializer
    
    init(manager: UserManagerProtocol = UserManager())
    {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    /// Call manager to fetch users in api
    func fetchUsers() {
        delegate?.loading(isLoading: true)
        manager.fetchUser { [weak self] result in
            sleep(1) // Force loading
            guard let self = self else { return }
            switch result {
            case .success(let users):
                handlerSuccess(users: users)
            case .failure(let error):
                self.handlerError(error)
            }
        }
    }
    
    /// Call manager to search the textField
    /// - Parameter search: TextField inputs
    func search(search: String) {
        delegate?.loading(isLoading: true)
        manager.searchUser(search: search) { [weak self] result in
            sleep(1) // Force loading
            guard let self = self else { return }
            switch result {
            case .success(let result):
                guard let searchUsers = result?.users, !searchUsers.isEmpty
                else { self.handlerSearchError()
                    return }
                self.handlerSuccess(users: searchUsers)
            case .failure(let error):
                self.handlerError(error)
            }
        }
    }
    
    // MARK: - Private Methods

    private func handlerSuccess(users: [UsersModel]?) {
        delegate?.loading(isLoading: false)
        self.delegate?.onUsersFetchSuccess(users)
    }

    private func handlerSearchError() {
        delegate?.loading(isLoading: false)
        self.delegate?.onUsersFetchError(StringHelper.errorTitleAlert, StringHelper.errorSearchMessageAlert)
    }
    
    private func handlerError(_ error: Error) {
        // Pode ser criado uma unica mensagem de error para o usuario, ou então de acordo com o tipo de erro abaixo.
        // Existe varias maneiras de capturar o erro e mostrar para o usuario de forma mais amigável.
        delegate?.loading(isLoading: false)
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
