//
//  UserManagerTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

@testable import UsersGitHub
import XCTest

final class UserManagerTests: XCTestCase {
    var sut: UserManager!
    var networkMock: UserOperationMock!

    override func setUp() {
        super.setUp()
        networkMock = UserOperationMock()
        sut = UserManager(network: networkMock)
    }

    override func tearDown() {
        sut = nil
        networkMock = nil
        super.tearDown()
    }

    func testFetchUserSuccess() {
        let expectedUsers = UsersModel.fixture()
        networkMock.successMock = expectedUsers

        let expectation = expectation(description: "fetchUser completion")
        var result: Result<[UsersModel]?, any Error>?

        sut.fetchUser { response in
            result = response
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedUsers)
            case .failure(let error):
                XCTFail("Expected success but got \(error)")
            case .none:
                XCTFail("Expected success but got nil")
            }
        }
    }

    func testSearchUser() {
        let searchQuery = "miguelflopes"
        let expectedSearchData = SearchUserModel.fixture()
        networkMock.successMock = expectedSearchData

        let expectation = expectation(description: "search completion")
        var result: Result<SearchUserModel?, any Error>?

        sut.searchUser(search: searchQuery) { response in
            result = response
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            switch result {
            case .success(let data):
                XCTAssertEqual(data?.users?.first?.login, searchQuery)
                XCTAssertEqual(data, expectedSearchData)
            case .failure(let error):
                XCTFail("Failed to search user with error: \(error.localizedDescription)")
            case .none:
                XCTFail("Expected success but got nil")
            }
        }
    }

    func testFetchUserDetails() {
        let userName = "miguelflopes"
        let expectedUserDetail = UserDetailModel.fixture()
        networkMock.successMock = expectedUserDetail

        let expectation = expectation(description: "details completion")
        var result: Result<[UserDetailModel]?, any Error>?

        sut.fetchUserDetails(userName: userName) { response in
            result = response
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            switch result {
            case .success(let data):
                XCTAssertEqual(data?.first?.owner?.login, userName)
                XCTAssertEqual(data, expectedUserDetail)

            case .failure(let error):
                XCTFail("Failed to fetch user details with error: \(error.localizedDescription)")
            case .none:
                XCTFail("Expected success but got nil")
            }
        }
    }
}
