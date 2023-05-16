//
//  UserDetailViewModelTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

@testable import UsersGitHub
import XCTest

class UserDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: UserDetailViewModel!
    var mockManager: UserManagerMock!
    var mockDelegate: UserDetailViewModelDelegateMock!

    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockManager = UserManagerMock()
        viewModel = UserDetailViewModel(userName: "miguel", manager: mockManager)
        mockDelegate = UserDetailViewModelDelegateMock()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockManager = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchUserDetailsSuccess() {
        mockManager.fetchUserDetailsResult = .success([userDetailMock])
        viewModel.fetchUserDetails()
        XCTAssertEqual(mockDelegate.userDetail, [userDetailMock])
    }
    
    func testFetchUserDetailsFailure() {
        let error = NetworkError.invalidURL
        mockManager.fetchUserDetailsResult = .failure(error)
        viewModel.fetchUserDetails()
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorAlert)
    }
}

// MARK: - UserDetailViewModelDelegateMock

class UserDetailViewModelDelegateMock: UserDetailViewModelDelegate {
    var userDetail: [UserDetailModel]?
    var errorTitle: String?
    var errorMessage: String?
    
    func onUsersFetchSuccess(_ userDetail: [UserDetailModel]) {
        self.userDetail = userDetail
    }
    
    func onUsersFetchError(_ title: String, _ message: String) {
        errorTitle = title
        errorMessage = message
    }
}
