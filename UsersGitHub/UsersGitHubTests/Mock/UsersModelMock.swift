//
//  UsersModelMock.swift
//  UsersGitHubTests
//
//  Created by hitss on 22/06/24.
//

import Foundation
@testable import UsersGitHub

extension UsersModel {
    static func fixture() -> [UsersModel] {
        return [UsersModel(login: "miguelflopes", id: 1234, nodeId: String(), avatarUrl: String(), gravatarId: String(), url: String(), htmlUrl: String(), followersUrl: String(), followingUrl: String(), gistsUrl: String(), starredUrl: String(), subscriptionsUrl: String(), organizationsUrl: String(), reposUrl: String(), eventsUrl: String(), receivedEventsUrl: String(), type: String(), siteAdmin: false, score: .zero)]
    }
}
