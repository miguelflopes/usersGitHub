//
//  UserDetailModelMock.swift
//  UsersGitHubTests
//
//  Created by hitss on 22/06/24.
//

import Foundation
@testable import UsersGitHub

extension UserDetailModel {
    static func fixture() -> [UserDetailModel] {
        let owner = UsersModel.fixture().first
        return [UserDetailModel(id: 1234, nodeID: String(), name: "miguel", fullName: String(), welcomePrivate: false, owner: owner, htmlURL: String(), description: String(), fork: false, url: String(), forksURL: String(), keysURL: String(), collaboratorsURL: String(), teamsURL: String(), hooksURL: String(), issueEventsURL: String(), eventsURL: String(), assigneesURL: String(), branchesURL: String(), tagsURL: String(), blobsURL: String(), gitTagsURL: String(), gitRefsURL: String(), treesURL: String(), statusesURL: String(), languagesURL: String(), stargazersURL: String(), contributorsURL: String(), subscribersURL: String(), subscriptionURL: String(), commitsURL: String(), gitCommitsURL: String(), commentsURL: String(), issueCommentURL: String(), contentsURL: String(), compareURL: String(), mergesURL: String(), archiveURL: String(), downloadsURL: String(), issuesURL: String(), pullsURL: String(), milestonesURL: String(), notificationsURL: String(), labelsURL: String(), releasesURL: String(), deploymentsURL: String(), createdAt: String(), updatedAt: String(), pushedAt: String(), gitURL: String(), sshURL: String(), cloneURL: String(), svnURL: String(), homepage: String(), size: .zero, stargazersCount: .zero, watchersCount: .zero, language: String(), hasIssues: false, hasProjects: false, hasDownloads: false, hasWiki: false, hasPages: false, hasDiscussions: false, forksCount: .zero, mirrorURL: String(), archived: false, disabled: false, openIssuesCount: .zero, license: License(key: String(), name: String(), spdxID: String(), url: String(), nodeID: String()), allowForking: false, isTemplate: false, webCommitSignoffRequired: false, topics: [String()], visibility: String(), forks: .zero, openIssues: .zero, watchers: .zero, defaultBranch: String())]
    }
}
