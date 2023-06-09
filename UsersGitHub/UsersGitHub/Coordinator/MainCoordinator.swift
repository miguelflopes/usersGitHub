//
//  MainCoordinator.swift
//  UsersGitHub
//
//  Created by Miguel on 26/05/23.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol {
    var navigationController: UINavigationController { get set }

    func start()
    func startDetails(_ userLogin: String)
    func openError(_ title: String, _ message: String)
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        startFlowUserViewController()
    }
    
    // MARK: - Flow User
    
    private func startFlowUserViewController() {
        let viewModel = UsersViewModel(coordinator: self)
        let usersViewController = UsersViewController(viewModel: viewModel)
        navigationController.pushViewController(usersViewController, animated: true)
    }
    
    // MARK: - Flow User Details
    
    func startDetails(_ userLogin: String) {
        let userDetailViewModel = UserDetailViewModel(userName: userLogin, coordinator: self)
        let userDetailViewController = UserDetailViewController(userName: userLogin, viewModel: userDetailViewModel)
        navigationController.pushViewController(userDetailViewController, animated: true)
    }
    
    // MARK: - Show Error
    
    func openError(_ title: String, _ message: String) {
        AlertController().showAlert(title: title, message: message, style: .default, navigation: navigationController) {
            self.navigationController.popViewController(animated: true)
        }
    }
}
