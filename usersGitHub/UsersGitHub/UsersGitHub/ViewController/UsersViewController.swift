//
//  UsersViewController.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation
import UIKit

final class UsersViewController: UIViewController {

    // MARK: - Private Properties

    private var viewModel: UsersViewModelProtocol
    private let dataSource: UsersDataSourceProtocol
    private var contentView: UserViewProtocol
    private weak var delegate: MainCoordinatorProtocol?

    // MARK: - Initializer

    init(viewModel: UsersViewModelProtocol,
         dataSource: UsersDataSourceProtocol,
         contentView: UserViewProtocol,
         delegate: MainCoordinatorProtocol?) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsers()
        bindActions()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view = contentView
        title = StringHelper.title
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    private func bindActions() {
        contentView.onFetchUser = { [weak self] in
            self?.viewModel.fetchUsers()
        }

        contentView.onSearch = { [weak self] textField in
            self?.viewModel.search(search: textField)
        }

        contentView.openDetails = { [weak self ] userLogin in
            self?.delegate?.startDetails(userLogin)
        }
    }
}

// MARK: - UsersViewModelDelegate

extension UsersViewController: UsersViewModelDelegate {
    func onUsersFetchSuccess(_ users: [UsersModel]?) {
        DispatchQueue.main.async {
            self.dataSource.users = users
            self.contentView.setupTableView(dataSource: self.dataSource)
        }
    }

    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String) {
        delegate?.openError(errorTitle, errorMessage)
    }
    
    func loading(isLoading: Bool) {
        contentView.loadingView(isLoading: isLoading)
    }
}
