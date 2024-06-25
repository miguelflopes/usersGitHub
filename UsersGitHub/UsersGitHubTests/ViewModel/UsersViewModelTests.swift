//
//  UsersViewModelTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 20/05/23.
//

@testable import UsersGitHub
import XCTest

final class UsersViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var coodinator: MainCoordinator!
    var sut: UsersViewModel!
    var mockManager: UserManagerMock!
    var mockDelegate: UsersViewModelDelegateMock!

    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockManager = UserManagerMock()
        coodinator = MainCoordinator(navigationController: MockNavigationController())
        sut = UsersViewModel(manager: mockManager)
        mockDelegate = UsersViewModelDelegateMock()
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        coodinator = nil
        sut = nil
        mockManager = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchUsersSuccess() {
        mockManager.fetchUserResult = .success(UsersModel.fixture())
        sut.fetchUsers()
        XCTAssertEqual(mockDelegate.users, UsersModel.fixture())
        XCTAssertEqual(mockManager.fetchUserCount, 1)
    }
    
    func testFetchUsersFailure() {
        let error = NetworkError.invalidURL
        mockManager.fetchUserResult = .failure(error)
        sut.fetchUsers()
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorAlert)
        XCTAssertEqual(mockManager.fetchUserCount, 1)
    }
    
    func testSearchSuccess() {
        let result = SearchUserModel(totalCount: .zero, incompleteResults: false, users: UsersModel.fixture())
        mockManager.searchUserResult = .success(result)
        sut.search(search: "miguel")
        XCTAssertEqual(mockDelegate.users, UsersModel.fixture())
        XCTAssertEqual(mockManager.searchUserCount, 1)
    }
    
    func testSearchEmptyResult() {
        let result = SearchUserModel(totalCount: .zero, incompleteResults: false, users: [])
        mockManager.searchUserResult = .success(result)
        sut.search(search: "miguel")
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorSearchMessageAlert)
        XCTAssertEqual(mockManager.searchUserCount, 1)
    }
    
    func testSearchFailure() {
        let error = NetworkError.invalidURL
        mockManager.searchUserResult = .failure(error)
        sut.search(search: "miguel")
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorAlert)
        XCTAssertEqual(mockManager.searchUserCount, 1)
    }
}
