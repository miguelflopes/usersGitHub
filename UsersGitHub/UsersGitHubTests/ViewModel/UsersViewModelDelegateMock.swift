//
//  UsersViewModelDelegateMock.swift
//  UsersGitHubTests
//
//  Created by hitss on 24/06/24.
//

import Foundation
@testable import UsersGitHub

// MARK: - UsersViewModelDelegateMock

final class UsersViewModelDelegateMock: UsersViewModelDelegate {
    var users: [UsersModel]?
    var errorTitle: String?
    var errorMessage: String?

    func onUsersFetchSuccess(_ users: [UsersModel]?) {
        self.users = users
    }

    func onUsersFetchError(_ title: String, _ message: String) {
        errorTitle = title
        errorMessage = message
    }

    func loading(isLoading _: Bool) {
        
    }
}
