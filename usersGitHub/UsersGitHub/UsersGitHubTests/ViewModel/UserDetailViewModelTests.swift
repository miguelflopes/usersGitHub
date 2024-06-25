//
//  UserDetailViewModelTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

@testable import UsersGitHub
import XCTest

final class UserDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var coodinator: MainCoordinator!
    var viewModel: UserDetailViewModel!
    var mockManager: UserManagerMock!
    var mockDelegate: UserDetailViewModelDelegateMock!

    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockManager = UserManagerMock()
        coodinator = MainCoordinator(navigationController: MockNavigationController())
        viewModel = UserDetailViewModel(userName: "miguel", manager: mockManager)
        mockDelegate = UserDetailViewModelDelegateMock()
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
    
    func testFetchUserDetailsSuccess() {
        mockManager.fetchUserDetailsResult = .success(UserDetailModel.fixture())
        viewModel.fetchUserDetails()
        XCTAssertEqual(mockDelegate.userDetail, UserDetailModel.fixture())
    }
    
    func testFetchUserDetailsFailure() {
        let error = NetworkError.invalidURL
        mockManager.fetchUserDetailsResult = .failure(error)
        viewModel.fetchUserDetails()
        XCTAssertEqual(mockDelegate.errorTitle, StringHelper.errorTitleAlert)
        XCTAssertEqual(mockDelegate.errorMessage, StringHelper.errorAlert)
    }
}
