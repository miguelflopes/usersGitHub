//
//  UserDetailDataSourceTests.swift
//  UsersGitHubTests
//
//  Created by hitss on 25/06/24.
//

import XCTest
@testable import UsersGitHub

final class UserDetailDataSourceTests: XCTestCase {
    var sut: UserDetailDataSource!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        sut = UserDetailDataSource()
        tableView = UITableView()
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.self.className)
    }

    override func tearDown() {
        sut = nil
        tableView = nil
        super.tearDown()
    }

    func testCellForRowAt() {
        let userDetail = UserDetailModel.fixture()
        sut.userDetail = userDetail

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath) as? UserDetailTableViewCell

        let nameLabel = cell?.findView(accessibilityIdentifier: "nameLabel") as? UILabel

        XCTAssertEqual(nameLabel?.text, "Name: \(userDetail[0].name ?? "")")
    }

    func testNumberOfRowsInSection() {
        let userDetail = UserDetailModel.fixture()
        sut.userDetail = userDetail

        let rows = sut.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, userDetail.count)
    }
}
