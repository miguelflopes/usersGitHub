//
//  UserDataSourceTests.swift
//  UsersGitHubTests
//
//  Created by hitss on 25/06/24.
//

import XCTest
@testable import UsersGitHub

final class UsersDataSourceTests: XCTestCase {
    var sut: UsersDataSource!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        sut = UsersDataSource()
        tableView = UITableView()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.self.className)
    }

    override func tearDown() {
        sut = nil
        tableView = nil
        super.tearDown()
    }

    func testCellForRowAt() {
        let users = UsersModel.fixture()
        sut.users = users

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath) as? UserTableViewCell

        let userLogin = cell?.findView(accessibilityIdentifier: "userLogin") as? UILabel

        XCTAssertEqual(userLogin?.text, users[0].login?.firstUppercased)
    }

    func testNumberOfRowsInSection() {
        let users = UsersModel.fixture()
        sut.users = users

        let rows = sut.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, users.count)
    }

    func testDidSelectRowAt() {
        let users = UsersModel.fixture()
        sut.users = users

        let expectation = self.expectation(description: "OpenDetails called")
        sut.openDetails = { login in
            XCTAssertEqual(login, users[0].login)
            expectation.fulfill()
        }
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(tableView, didSelectRowAt: indexPath)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testHeightForRowAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        let height = sut.tableView(tableView, heightForRowAt: indexPath)
        XCTAssertEqual(height, 80)
    }
}
