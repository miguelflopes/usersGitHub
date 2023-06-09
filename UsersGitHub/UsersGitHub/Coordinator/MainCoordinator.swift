//
//  MainCoordinator.swift
//  UsersGitHub
//
//  Created by HITSS on 26/05/23.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol {
    var navigationController: UINavigationController { get set }

    func start()
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        startFlowUserViewController()
    }
    
    private func startFlowUserViewController() {
        let usersViewController = UsersViewController()
        usersViewController.openDetails = openFlowDetails
        usersViewController.openError = openError
        navigationController.pushViewController(usersViewController, animated: true)
    }
}

// MARK: - Flow User Details

extension MainCoordinator {
    private func openFlowDetails(_ userLogin: String) {
        let userDetailViewModel = UserDetailViewModel(userName: userLogin)
        let userDetailViewController = UserDetailViewController(userName: userLogin, viewModel: userDetailViewModel)
        userDetailViewController.openError = openError
        navigationController.pushViewController(userDetailViewController, animated: true)
    }
}

// MARK: - Error

extension MainCoordinator {
    private func openError(_ title: String, _ message: String) {
        AlertController().showAlert(title: title, message: message, style: .default, navigation: navigationController) {
            self.navigationController.popViewController(animated: true)
        }
    }
}
