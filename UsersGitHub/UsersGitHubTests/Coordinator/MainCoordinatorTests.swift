//
//  MainCoordinatorTests.swift
//  UsersGitHubTests
//
//  Created by Miguel on 27/05/23.
//

@testable import UsersGitHub
import XCTest

final class MainCoordinatorTests: XCTestCase {

    func testStartFlowUserViewController() {
        let navigationController = MockNavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)

        coordinator.start()

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is UsersViewController)
    }

    func testOpenFlowDetails() {
        let navigationController = MockNavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)
        let userLogin = "Miguel"
        coordinator.startDetails(userLogin)
        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.last is UserDetailViewController)
        let userDetailViewController = navigationController.viewControllers.last as? UserDetailViewController
        userDetailViewController?.loadView()
        XCTAssertEqual(userDetailViewController?.title, userLogin)
    }

    func testOpenError() {
        let navigationController = MockNavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)
        
        let title = "Error title"
        let message = "Error description"
        coordinator.openError(title, message)
        XCTAssertTrue(navigationController.presentedController is UIAlertController)
    }
}
