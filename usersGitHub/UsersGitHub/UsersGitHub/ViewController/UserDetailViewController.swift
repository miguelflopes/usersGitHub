//
//  UserDetailViewController.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation
import UIKit

final class UserDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: UserDetailViewModelProtocol
    private let contentView: UserDetailViewProtocol
    private let dataSource: UserDetailDataSourceProtocol
    private let userName: String
    private weak var delegate: MainCoordinatorProtocol?

    // MARK: - Initializers

    init(userName: String, 
         viewModel: UserDetailViewModelProtocol,
         dataSource: UserDetailDataSourceProtocol,
         contentView: UserDetailViewProtocol,
         delegate: MainCoordinatorProtocol?) {
        self.viewModel = viewModel
        self.contentView = contentView
        self.dataSource = dataSource
        self.userName = userName
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUserDetails()
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view = contentView
        title = userName.firstUppercased
    }
}


// MARK: - UserDetailViewModelDelegate

extension UserDetailViewController: UserDetailViewModelDelegate {
    func onUsersFetchSuccess(_ userDetail: [UserDetailModel]?) {
        dataSource.userDetail = userDetail
        contentView.setupTableView(dataSource: self.dataSource)
    }
    
    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String) {
        delegate?.openError(errorTitle, errorMessage)
    }

    func loading(isLoading: Bool) {
        contentView.loadingView(isLoading: isLoading)
    }
}
