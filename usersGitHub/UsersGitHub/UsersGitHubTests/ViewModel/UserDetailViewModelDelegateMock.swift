//
//  UserDetailViewModelDelegateMock.swift
//  UsersGitHubTests
//
//  Created by hitss on 24/06/24.
//

import Foundation
@testable import UsersGitHub

// MARK: - UserDetailViewModelDelegateMock

final class UserDetailViewModelDelegateMock: UserDetailViewModelDelegate {
    var userDetail: [UserDetailModel]?
    var errorTitle: String?
    var errorMessage: String?

    func onUsersFetchSuccess(_ userDetail: [UserDetailModel]?) {
        self.userDetail = userDetail
    }

    func onUsersFetchError(_ title: String, _ message: String) {
        errorTitle = title
        errorMessage = message
    }

    func loading(isLoading _: Bool) {
    }
}
