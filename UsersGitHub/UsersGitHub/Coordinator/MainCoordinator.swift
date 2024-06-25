//
//  MainCoordinator.swift
//  UsersGitHub
//
//  Created by Miguel on 26/05/23.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol: AnyObject {
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
        let viewModel = UsersViewModel()
        let dataSource = UsersDataSource()
        let view = UserView()
        let viewController = UsersViewController(viewModel: viewModel,
                                                 dataSource: dataSource,
                                                 contentView: view,
                                                 delegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Flow User Details
    
    func startDetails(_ userLogin: String) {
        let viewModel = UserDetailViewModel(userName: userLogin)
        let dataSource = UserDetailDataSource()
        let view = UserDetailView()
        let detailViewController = UserDetailViewController(userName: userLogin,
                                                            viewModel: viewModel, 
                                                            dataSource: dataSource,
                                                            contentView: view,
                                                            delegate: self)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Show Error
    
    func openError(_ title: String, _ message: String) {
        AlertController().showAlert(title: title, message: message, style: .default, navigation: navigationController) {
            self.navigationController.popViewController(animated: true)
        }
    }
}
