//
//  UserDetailViewTests.swift
//  UsersGitHubTests
//
//  Created by hitss on 25/06/24.
//

import XCTest
@testable import UsersGitHub

final class UserDetailViewTests: XCTestCase {
    var sut: UserDetailView!

    override func setUp() {
        super.setUp()
        sut = UserDetailView()
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
