//
//  UserDetailViewModel.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

protocol UserDetailViewModelDelegate: AnyObject {
    func onUsersFetchSuccess(_ userDetail: [UserDetailModel]?)
    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String)
    func loading(isLoading _: Bool)
}

final class UserDetailViewModel: UserDetailViewModelProtocol {
    
    // MARK: - Public Properties
    
    weak var delegate: UserDetailViewModelDelegate?

    // MARK: - Private Properties
    
    private let manager: UserManagerProtocol
    private var userName: String
    
    // MARK: - Initializer
    
    init(userName: String, 
         manager: UserManagerProtocol = UserManager(session: .shared, apiClient: PathAPI()))
    {
        self.manager = manager
        self.userName = userName
    }
    
    /// Call manager to fetch users details in api
    func fetchUserDetails() {
        delegate?.loading(isLoading: true)
        manager.fetchUserDetails(userName: userName) { [weak self] result in
            sleep(1) // Force loading
            guard let self = self else { return }
            switch result {
            case .success(let userDetail):
                self.handlerSuccess(userDetail)
            case .failure(let error):
                self.handlerError(error)
            }
        }
    }
    
    private func handlerSuccess(_ userDetail: [UserDetailModel]?) {
        delegate?.loading(isLoading: false)
        self.delegate?.onUsersFetchSuccess(userDetail)
    }
    
    private func handlerError(_ error: Error) {
        // Pode ser criado uma unica mensagem de error para o usuario, ou então de acordo com o tipo de erro abaixo.
        // Existe varias maneiras de capturar o erro e mostrar para o usuario de forma mais amigavel.
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
