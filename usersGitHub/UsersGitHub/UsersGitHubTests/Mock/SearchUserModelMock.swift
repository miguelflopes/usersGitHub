//
//  SearchUserModelMock.swift
//  UsersGitHubTests
//
//  Created by hitss on 24/06/24.
//

import Foundation
@testable import UsersGitHub

extension SearchUserModel {
    static func fixture() -> SearchUserModel {
        return SearchUserModel(totalCount: 1, incompleteResults: false, users: UsersModel.fixture())
    }
}
