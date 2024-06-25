//
//  UserViewTests.swift
//  UsersGitHubTests
//
//  Created by hitss on 25/06/24.
//

import XCTest
@testable import UsersGitHub

final class UserViewTests: XCTestCase {
    var sut: UserView!

    override func setUp() {
        super.setUp()
        sut = UserView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadingViewHidden() {
        let loading = sut.findView(accessibilityIdentifier: "loadingView") as? LoadingView
        sut.loadingView(isLoading: false)
        XCTAssertTrue(loading?.isHidden ?? false)
    }

    func testLoadingShow() {
        let loading = sut.findView(accessibilityIdentifier: "loadingView") as? LoadingView
        sut.loadingView(isLoading: true)
        XCTAssertFalse(loading?.isHidden ?? true)
    }
}
