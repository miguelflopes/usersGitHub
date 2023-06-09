//
//  MainCoordinatorTests.swift
//  UsersGitHubTests
//
//  Created by HITSS on 27/05/23.
//

@testable import UsersGitHub
import XCTest

class MainCoordinatorTests: XCTestCase {

    func testStartFlowUserViewController() {
        let navigationController = MockNavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)

        coordinator.start()

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is UsersViewController)

        let usersViewController = navigationController.viewControllers.first as? UsersViewController
        XCTAssertNotNil(usersViewController?.openDetails)
    }

    func testOpenFlowDetails() {
        let navigationController = MockNavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)

        let startFlowUserDetail: ((String) -> ()) = ("") -> ()
        
        let usersViewController = UsersViewController()
        usersViewController.openDetails = startFlowUserDetail
        let userLogin = "john_doe"
//        coordinator.openFlowDetails(userLogin)
        

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is UserDetailViewController)

        let userDetailViewController = navigationController.viewControllers.first as? UserDetailViewController
//        XCTAssertEqual(userDetailViewController.userName, userLogin)
//        XCTAssertNotNil(userDetailViewController.viewModel)
    }

    func testStart() {
        let navigationController = MockNavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)

        coordinator.start()

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is UsersViewController)
    }
}

// MockNavigationController para simular o comportamento do UINavigationController
class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

