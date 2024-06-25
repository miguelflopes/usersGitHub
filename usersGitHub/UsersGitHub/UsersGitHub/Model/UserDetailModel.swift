//
//  UserDetailModel.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

public struct UserDetailModel: Codable, Equatable {
    let id: Int?
    let nodeID: String?
    let name: String?
    let fullName: String?
    let welcomePrivate: Bool?
    let owner: UsersModel?
    let htmlURL: String?
    let description: String?
    let fork: Bool?
    let url: String?
    let forksURL: String?
    let keysURL: String?
    let collaboratorsURL: String?
    let teamsURL: String?
    let hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL: String?
    let branchesURL: String?
    let tagsURL: String?
    let blobsURL: String?
    let gitTagsURL: String?
    let gitRefsURL: String?
    let treesURL: String?
    let statusesURL: String?
    let languagesURL: String?
    let stargazersURL: String?
    let contributorsURL: String?
    let subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL: String?
    let gitCommitsURL: String?
    let commentsURL: String?
    let issueCommentURL: String?
    let contentsURL: String?
    let compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL: String?
    let pullsURL: String?
    let milestonesURL: String?
    let notificationsURL: String?
    let labelsURL: String?
    let releasesURL: String?
    let deploymentsURL: String?
    let createdAt: String?
    let updatedAt: String?
    let pushedAt: String?
    let gitURL: String?
    let sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: String?
    let size: Int?
    let stargazersCount: Int?
    let watchersCount: Int?
    let language: String?
    let hasIssues: Bool?
    let hasProjects: Bool?
    let hasDownloads: Bool?
    let hasWiki: Bool?
    let hasPages: Bool?
    let hasDiscussions: Bool?
    let forksCount: Int?
    let mirrorURL: String?
    let archived: Bool?
    let disabled: Bool?
    let openIssuesCount: Int?
    let license: License?
    let allowForking: Bool?
    let isTemplate: Bool?
    let webCommitSignoffRequired: Bool?
    let topics: [String]?
    let visibility: String?
    let forks: Int?
    let openIssues: Int?
    let watchers: Int?
    let defaultBranch: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case welcomePrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description, fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case webCommitSignoffRequired = "web_commit_signoff_required"
        case topics
        case visibility
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
    }
    
    public static func == (lhs: UserDetailModel, rhs: UserDetailModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.nodeID == rhs.nodeID &&
        lhs.name == rhs.name &&
        lhs.fullName == rhs.fullName &&
        lhs.welcomePrivate == rhs.welcomePrivate &&
        lhs.owner == rhs.owner &&
        lhs.htmlURL == rhs.htmlURL &&
        lhs.description == rhs.description &&
        lhs.fork == rhs.fork &&
        lhs.url == rhs.url &&
        lhs.forksURL == rhs.forksURL &&
        lhs.keysURL == rhs.keysURL &&
        lhs.collaboratorsURL == rhs.collaboratorsURL &&
        lhs.teamsURL == rhs.teamsURL &&
        lhs.hooksURL == rhs.hooksURL &&
        lhs.issueEventsURL == rhs.issueEventsURL &&
        lhs.eventsURL == rhs.eventsURL &&
        lhs.assigneesURL == rhs.assigneesURL &&
        lhs.branchesURL == rhs.branchesURL &&
        lhs.tagsURL == rhs.tagsURL &&
        lhs.blobsURL == rhs.blobsURL &&
        lhs.gitTagsURL == rhs.gitTagsURL &&
        lhs.gitRefsURL == rhs.gitRefsURL &&
        lhs.treesURL == rhs.treesURL &&
        lhs.statusesURL == rhs.statusesURL &&
        lhs.languagesURL == rhs.languagesURL &&
        lhs.stargazersURL == rhs.stargazersURL &&
        lhs.contributorsURL == rhs.contributorsURL &&
        lhs.subscribersURL == rhs.subscribersURL &&
        lhs.subscriptionURL == rhs.subscriptionURL &&
        lhs.commitsURL == rhs.commitsURL &&
        lhs.gitCommitsURL == rhs.gitCommitsURL &&
        lhs.commentsURL == rhs.commentsURL &&
        lhs.issueCommentURL == rhs.issueCommentURL &&
        lhs.contentsURL == rhs.contentsURL &&
        lhs.compareURL == rhs.compareURL &&
        lhs.mergesURL == rhs.mergesURL &&
        lhs.archiveURL == rhs.archiveURL &&
        lhs.downloadsURL == rhs.downloadsURL &&
        lhs.issuesURL == rhs.issuesURL &&
        lhs.pullsURL == rhs.pullsURL &&
        lhs.milestonesURL == rhs.milestonesURL &&
        lhs.notificationsURL == rhs.notificationsURL &&
        lhs.labelsURL == rhs.labelsURL &&
        lhs.releasesURL == rhs.releasesURL &&
        lhs.deploymentsURL == rhs.deploymentsURL &&
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.pushedAt == rhs.pushedAt &&
        lhs.gitURL == rhs.gitURL &&
        lhs.sshURL == rhs.sshURL &&
        lhs.cloneURL == rhs.cloneURL &&
        lhs.svnURL == rhs.svnURL &&
        lhs.homepage == rhs.homepage &&
        lhs.size == rhs.size &&
        lhs.stargazersCount == rhs.stargazersCount &&
        lhs.watchersCount == rhs.watchersCount &&
        lhs.language == rhs.language &&
        lhs.hasIssues == rhs.hasIssues &&
        lhs.hasProjects == rhs.hasProjects &&
        lhs.hasDownloads == rhs.hasDownloads &&
        lhs.hasWiki == rhs.hasWiki &&
        lhs.hasPages == rhs.hasPages &&
        lhs.hasDiscussions == rhs.hasDiscussions &&
        lhs.forksCount == rhs.forksCount &&
        lhs.mirrorURL == rhs.mirrorURL &&
        lhs.archived == rhs.archived &&
        lhs.disabled == rhs.disabled &&
        lhs.openIssuesCount == rhs.openIssuesCount &&
        lhs.license == rhs.license &&
        lhs.allowForking == rhs.allowForking &&
        lhs.isTemplate == rhs.isTemplate &&
        lhs.webCommitSignoffRequired == rhs.webCommitSignoffRequired &&
        lhs.topics == rhs.topics &&
        lhs.visibility == rhs.visibility &&
        lhs.forks == rhs.forks &&
        lhs.openIssues == rhs.openIssues &&
        lhs.watchers == rhs.watchers &&
        lhs.defaultBranch == rhs.defaultBranch
    }
}

// MARK: - License

public struct License: Codable, Equatable {
    let key: String?
    let name: String?
    let spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
