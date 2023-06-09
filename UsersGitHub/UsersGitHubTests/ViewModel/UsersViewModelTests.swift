//
//  UsersViewModelTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

@testable import UsersGitHub
import XCTest

class UsersViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var coodinator: MainCoordinator!
    var viewModel: UsersViewModel!
    var mockManager: UserManagerMock!
    var mockDelegate: UsersViewModelDelegateMock!

    let users: [UsersModel] = [UsersModel(login: "miguel", id: 1234, nodeId: String(), avatarUrl: String(), gravatarId: String(), url: String(), htmlUrl: String(), followersUrl: String(), followingUrl: String(), gistsUrl: String(), starredUrl: String(), subscriptionsUrl: String(), organizationsUrl: String(), reposUrl: String(), eventsUrl: String(), receivedEventsUrl: String(), type: String(), siteAdmin: false, score: .zero)]
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockManager = UserManagerMock()
        coodinator = MainCoordinator(navigationController: MockNavigationController())
        viewModel = UsersViewModel(coordinator: coodinator, manager: mockManager)
        mockDelegate = UsersViewModelDelegateMock()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        coodinator = nil
        viewModel = nil
        mockManager = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchUsersSuccess() {
        mockManager.fetchUserResult = .success(users)
        viewModel.fetchUsers()
        XCTAssertEqual(mockDelegate.users, users)
    }
    
    func testFetchUsersFailure() {
        let error = NetworkError.invalidURL
        mockManager.fetchUserResult = .failure(error)
        viewModel.fetchUsers()
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorAlert)
    }
    
    func testSearchSuccess() {
        let result = SearchUserModel(totalCount: .zero, incompleteResults: false, users: users)
        mockManager.searchUserResult = .success(result)
        viewModel.search(search: "miguel")
        XCTAssertEqual(mockDelegate.users, users)
    }
    
    func testSearchEmptyResult() {
        let result = SearchUserModel(totalCount: .zero, incompleteResults: false, users: [])
        mockManager.searchUserResult = .success(result)
        viewModel.search(search: "miguel")
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorSearchMessageAlert)
    }
    
    func testSearchFailure() {
        let error = NetworkError.invalidURL
        mockManager.searchUserResult = .failure(error)
        viewModel.search(search: "miguel")
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorAlert)
    }
}

// MARK: - UsersViewModelDelegateMock

class UsersViewModelDelegateMock: UsersViewModelDelegate {
    var users: [UsersModel]?
    var errorTitle: String?
    var errorMessage: String?
    
    func onUsersFetchSuccess(_ users: [UsersModel]) {
        self.users = users
    }
    
    func onUsersFetchError(_ title: String, _ message: String) {
        errorTitle = title
        errorMessage = message
    }
}
