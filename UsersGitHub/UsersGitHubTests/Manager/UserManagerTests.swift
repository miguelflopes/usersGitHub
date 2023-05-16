//
//  UserManagerTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 16/05/23.
//

@testable import UsersGitHub
import XCTest

class UserManagerTests: XCTestCase {
    var session: URLSession!
    var manager: UserManager!
    
    override func setUp() {
        super.setUp()
        session = URLSession.shared
        manager = UserManager(session: session)
    }
    
    override func tearDown() {
        session = nil
        manager = nil
        super.tearDown()
    }
    
    func testFetchUser() {
        let expectation = XCTestExpectation(description: "fetch")
        manager.fetchUser { result in
            switch result {
            case .success(let users):
                XCTAssertFalse(users.isEmpty)
            case .failure(let error):
                XCTFail("Failed to fetch users with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchUser() {
        let searchQuery = "miguelflopes"
        let expectation = XCTestExpectation(description: "search")
        manager.searchUser(search: searchQuery) { result in
            switch result {
            case .success(let searchUser):
                XCTAssertEqual(searchUser.users?.first?.login, searchQuery)
            case .failure(let error):
                XCTFail("Failed to search user with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchUserDetails() {
        let userName = "miguel"
        let expectation = XCTestExpectation(description: "FetchDetails")
        manager.fetchUserDetails(userName: userName) { result in
            switch result {
            case .success(let userDetails):
                XCTAssertFalse(userDetails.isEmpty)
                XCTAssertEqual(userDetails.first?.owner?.login, userName)
            case .failure(let error):
                XCTFail("Failed to fetch user details with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
