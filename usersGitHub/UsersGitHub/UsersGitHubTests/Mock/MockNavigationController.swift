//
//  MockNavigationController.swift
//  UsersGitHubTests
//
//  Created by Miguel on 09/06/23.
//

@testable import UsersGitHub
import XCTest

final class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var presentedController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedController = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
